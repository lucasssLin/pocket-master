<template>
    <div class="app-container">
  
      <!-- 搜索表单 -->
      <el-form ref="queryRef" :inline="true" label-width="100px">
        <el-form-item label="Brand Name" prop="name">
          <el-input
            v-model="queryParams.name"
            placeholder="Please enter brand name"
            clearable
          />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" icon="Search" @click="handleQuery">Search</el-button>
          <el-button icon="Refresh" @click="resetQuery">Reset</el-button>
        </el-form-item>
      </el-form>
  
      <!-- 功能按钮栏 -->
      <el-row :gutter="10" class="mb8">
        <el-col :span="1.5">
          <el-button
            type="primary"
            plain
            icon="Plus"
            @click="handleAdd"
            v-hasPermi="['product:brand:add']"
          >Add</el-button>
        </el-col>
        <el-col :span="1.5">
          <el-button
            type="success"
            plain
            icon="Edit"
            :disabled="single"
            @click="handleUpdate"
            v-hasPermi="['product:brand:edit']"
          >Edit</el-button>
        </el-col>
        <el-col :span="1.5">
          <el-button
            type="danger"
            plain
            icon="Delete"
            :disabled="multiple"
            @click="handleDelete"
            v-hasPermi="['product:brand:remove']"
          >Delete</el-button>
        </el-col>
      </el-row>
  
      <!-- 数据展示表格 -->
      <el-table :data="brandList" @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="55" align="center" />
        <el-table-column label="Brand Name" prop="name" width="200"/>
        <el-table-column label="Brand Logo" prop="logo" #default="scope">
          <img :src="scope.row.logo" width="50" />
        </el-table-column>
        <el-table-column prop="createTime" label="Create Time" />
        <el-table-column label="Operation" align="center" class-name="small-padding fixed-width">
          <template #default="scope">
            <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['product:brand:edit']">Edit</el-button>
            <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['product:brand:remove']">Delete</el-button>
          </template>
        </el-table-column>
      </el-table>
  
      <!-- 分页条组件 -->
      <pagination
          v-show="total > 0"
          :total="total"
          v-model:page="queryParams.pageNum"
          v-model:limit="queryParams.pageSize"
          @pagination = "getList"
      />
  

      <!-- 新增或修改分类品牌对话框 -->
      <el-dialog :title="title" v-model="open" width="500px" append-to-body>
          <el-form ref="brandRef" :model="form" label-width="120px" :rules="rules">
              <el-form-item label="Brand Name" prop="name">
                  <el-input v-model="form.name" placeholder="Please enter brand name" />
              </el-form-item>
              <el-form-item label="Brand Logo" prop="logo">
                  <el-upload
                            class="avatar-uploader"
                            :action="imgUpload.url"
                            :headers="imgUpload.headers"
                            :show-file-list="false"
                            :on-success="handleAvatarSuccess"
                            >
                      <img v-if="form.logo" :src="form.logo" class="avatar" />
                      <el-icon v-else class="avatar-uploader-icon"><Plus /></el-icon>
                  </el-upload>
              </el-form-item>
          </el-form>
          <template #footer>
              <div class="dialog-footer">
                  <el-button type="primary" @click="submitForm">Confirm</el-button>
                  <el-button @click="cancelForm">Cancel</el-button>
              </div>
          </template>
      </el-dialog>

    </div>
  </template>
  
  <script setup name="Brand">
  //引入api接口
import { listBrand, addBrand,getBrand, updateBrand,delBrand } from "@/api/product/brand";
import { getCurrentInstance, onMounted, reactive, toRefs } from "vue";
import {getToken} from '@/utils/auth.js';
import { ElMain, ElMessage, ElMessageBox } from "element-plus";

  //定义分页列表数据模型
  const brandList = ref([]);
  //定义列表总记录数模型
  const total = ref(2);
  //加载数据时显示的动效控制模型
  const loading = ref(true);


  const data =reactive({
    queryParams:{
      name: null,
      pageNum: 1,
      pageSize: 10
    },
    form: {},
    imgUpload:{
      headers:{Authorization: "Bearer " + getToken()},
      url: import.meta.env.VITE_APP_BASE_API + "/file/upload/minio"
    },
    rules:{
      name:[{required:true, message: "Brand name cannot be empty", trigger:"blur"}],
      logo:[{required:true, message: "Brand logo cannot be empty", trigger:"blur"}]
    }
  });

  const{queryParams, form, imgUpload, rules} = toRefs(data);

  ////////////新增属性//////////////////////
  //新增与修改弹出层控制模型
  const open = ref(false)
  //新增与修改弹出层标题模型
  const title = ref("")

  ////////////批量操作属性///////////////////
  //定义批量操作id列表模型
  const ids =ref([])
  //定义单选控制模型
  const single = ref(true)
  //定义多选控制模型
  const multiple = ref(true)

  const {proxy} = getCurrentInstance();

  ///////////////////////////////function/////////////////////////////////

  const getList=()=>{
    loading.value=true;
    listBrand(queryParams.value).then(response=>{
      brandList.value=response.rows;
      total.value = response.total;
      loading.value = false;
    })
  }

  onMounted(()=>{
    getList();
  })

  /** 搜索按钮操作 */
  const handleQuery=()=>{
    getList();
  }

/** 重置按钮操作 */
  const resetQuery=()=>{
    queryParams.value.name = null;
    proxy.resetForm("queryRef");
    getList();
  }

  // 表单重置
  const reset=()=>{
    form.value.name = null;
    form.value.logo = null;
    form.value.id = null;// 在用户点击修改后又点击了新增，避免操作冲突
    proxy.resetForm["brandRef"]
  }

// 新增按钮操作 
  const handleAdd=()=>{
    reset();
    open.value = true;
    title.value = "新增品牌";
  }

//上传图片
  const handleAvatarSuccess=(response, uploadFile)=>{
    form.value.logo=response.data.url;
  }

// 提交按钮
  function submitForm(){
    proxy.$refs["brandRef"].validate((valid)=>{
      if(valid){
        if(form.value.id == null){
          //新增
          addBrand(form.value).then(response=>{
            if(response.code === 200){
              proxy.$modal.msgSuccess("新增成功");
              open.value = false;
              getList();
            }else{
              ElMessage.error(response.msg);
            }
          })
        }else{
          updateBrand(form.value).then(response=>{
            if(response.code === 200){
              proxy.$modal.msgSuccess("修改成功");
              open.value = false;
              getList();
            }else{
              ElMessage.error(response.msg);
            }
          })
        }
      }else{
        proxy.$modal.msgError("校验失败");
      }
    })
  }
//  const submitForm=async()=>{
//     if(form.value.id == null){
//     const{code} = await addBrand(form.value);
//     if(code === 200){
//       proxy.$modal.msgSuccess("新增成功");
//       open.value = false;
//       getList();
//     }else{
//       proxy.$modal.msgError("新增失败");
//     }
//   } else {
//     const{code} = await updateBrand(form.value);
//     if(code === 200){
//       proxy.$modal.msgSuccess("修改成功");
//       open.value = false;
//       getList();
//     }else{
//       proxy.$modal.msgError("修改失败");
//     }
//   }
//  }

// 取消按钮
 const cancelForm=()=>{
  open.value = false;
  reset();
 }



 const handleSelectionChange=(selection)=>{
  ids.value = selection.map(item=>item.id)
  const i = selection.length;
  //删除按钮
  multiple.value = i === 0;
  //修改按钮
  single.value = i != 1;
 }


 // 修改按钮操作
 const handleUpdate =async(row)=>{
  reset();
  const _id = row.id || ids.value;
  const{data} = await getBrand(_id);
  form.value = data;
  open.value = true;
  title.value = "Edit Brand";
 }


// 删除按钮操作
 const handleDelete=async(row)=>{
  const _ids = row.id || ids.value;

  ElMessageBox.confirm(
    '是否确认删除分类品牌编号为"' + _ids + '"的数据项？',
    "删除操作",
    {
      confirmButtonText: "确定",
      cancelButtonText: "取消",
      type: "warning",
    }
  ).then((response)=>{
    delBrand(_ids).then((response)=>{
      proxy.$modal.msgSuccess("删除成功");
      open.value=false;
      getList();
    })
  }).catch((response)=>{
    ElMessage.info("取消删除");
    open.value = false;
  })
 }










  </script>

<style scoped>
.avatar-uploader .avatar {
    width: 178px;
    height: 178px;
    display: block;
}
</style>

<style>
.avatar-uploader .el-upload {
    border: 1px dashed var(--el-border-color);
    border-radius: 6px;
    cursor: pointer;
    position: relative;
    overflow: hidden;
    transition: var(--el-transition-duration-fast);
}

.avatar-uploader .el-upload:hover {
    border-color: var(--el-color-primary);
}

.el-icon.avatar-uploader-icon {
    font-size: 28px;
    color: #8c939d;
    width: 178px;
    height: 178px;
    text-align: center;
}
</style>