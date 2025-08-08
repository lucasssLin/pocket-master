<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="95px">

      <el-form-item label="KeyWord">
        <el-input
            style="width: 100%"
            v-model="queryParams.username"
            placeholder="UserName, Phone"
        ></el-input>
      </el-form-item>
      <el-form-item label="Create Time" style="width: 308px">
        <el-date-picker
            v-model="dateRange"
            value-format="YYYY-MM-DD"
            type="daterange"
            range-separator="-"
            start-placeholder="Start Date"
            end-placeholder="End Date"
        ></el-date-picker>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">Search</el-button>
        <el-button icon="Refresh" @click="resetQuery">Reset</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
            type="warning"
            plain
            icon="Download"
            @click="handleExport"
            v-hasPermi="['user:userInfo:export']"
        >Export</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="userInfoList">
      <el-table-column prop="username" label="UserName" />
      <el-table-column prop="nickName" label="NickName" />
      <el-table-column prop="avatar" label="Avatar" #default="scope">
        <img :src="scope.row.avatar" width="50" />
      </el-table-column>
      <el-table-column prop="status" label="Gender" #default="scope">
        {{ scope.row.sex == 1 ? 'Female' : 'Male' }}
      </el-table-column>
      <el-table-column prop="phone" label="PhoneNumber" />
      <el-table-column
          prop="lastLoginTime"
          label="LastLoginTime"
          width="170"
      />
      <el-table-column prop="status" label="Status" #default="scope">
        {{ scope.row.status == 1 ? 'Normal' : 'Disabled' }}
      </el-table-column>
      <el-table-column prop="createTime" label="CreateTime" width="160" />
      <el-table-column label="Operation" align="center" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" @click="handleShow(scope.row)" v-hasPermi="['user:userInfo:list']">Detail</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination
        v-show="total>0"
        :total="total"
        v-model:page="queryParams.pageNum"
        v-model:limit="queryParams.pageSize"
        @pagination="getList"
    />

    <!-- 添加或修改会员对话框 -->
    <el-dialog :title="title" v-model="open" width="50%" append-to-body>
      <el-form ref="userInfoRef" :model="form" :rules="rules" label-width="120px">
        <el-divider />
        <span style="margin-bottom: 5px;">Basic Infomation</span>
        <el-row>
          <el-col :span="12">
            <el-form-item label="Avatar">
              <img :src="form.avatar" width="50" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="UserName">
              {{ form.username }}
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="NickName">
              {{ form.nickName }}
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="Gender">
              {{ form.sex == 1 ? 'Female' : 'Male' }}
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="Phone">
              {{ form.phone }}
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="Remark">
              {{ form.memo }}
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="Last Login IP">
              {{ form.lastLoginIp }}
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="Last Login Time">
              {{ form.lastLoginTime }}
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="Status">
              {{ form.status == 1 ? 'Normal' : 'Disabled' }}
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="Create Time">
              {{ form.createTime }}
            </el-form-item>
          </el-col>
        </el-row>

        <el-divider />
        <span style="margin-bottom: 5px;">Address Information</span>
        <el-table :data="userAddressList" style="width: 100%">
          <el-table-column prop="tagName" label="Type" width="80" />
          <el-table-column
              prop="isDefault"
              label="Default"
              #default="scope"
              width="100"
          >
            {{ scope.row.isDefault == 1 ? 'Yes' : 'No' }}
          </el-table-column>
          <el-table-column prop="isDefault" label="Detail Address" #default="scope">
            {{ scope.row.name }} | {{ scope.row.phone }} |
            {{ scope.row.fullAddress }}
          </el-table-column>
          <el-table-column prop="createTime" label="Create Time" width="160" />
        </el-table>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button @click="cancel">Cancel</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="UserInfo">
import { listUserInfo, getUserAddress } from "@/api/user/userInfo";

const { proxy } = getCurrentInstance();

const userInfoList = ref([]);
const open = ref(false);
const loading = ref(true);
const showSearch = ref(true);
const total = ref(0);
const title = ref("");

const data = reactive({
  form: {},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    username: null,
    createTimeBegin: '',
    createTimeEnd: ''
  }
});

const { queryParams, form } = toRefs(data);

const dateRange = ref([]);
/** 查询会员列表 */
function getList() {
  loading.value = true;

  listUserInfo(proxy.addDateRange(queryParams.value, dateRange.value)).then(response => {
    userInfoList.value = response.rows;
    total.value = response.total;
    loading.value = false;
  });
}

// 取消按钮
function cancel() {
  open.value = false;
  form.value = {}
}

/** 搜索按钮操作 */
function handleQuery() {
  queryParams.value.pageNum = 1;
  getList();
}

/** 重置按钮操作 */
function resetQuery() {
  dateRange.value = [];
  proxy.resetForm("queryRef");
  handleQuery();
}

/** 修改按钮操作 */
const userAddressList = ref([])
function handleShow(row) {
  form.value = row;
  open.value = true;
  title.value = "User Information";

  getUserAddress(row.id).then(response => {
    userAddressList.value = response.data
  })
}

/** 导出按钮操作 */
function handleExport() {
  proxy.download('user/userInfo/export', {
    ...queryParams.value
  }, `userInfo_${new Date().getTime()}.xlsx`)
}

getList();
</script>