<template>
    <div class="app-container">
  
      <!-- 搜索表单 -->
      <el-form ref="queryRef" :inline="true" label-width="68px">
        <el-form-item label="Name" prop="name">
          <el-input
              v-model="queryParams.name"
              placeholder="Please enter name"
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
          >Add</el-button>
        </el-col>
        <el-col :span="1.5">
          <el-button
              type="success"
              plain
              icon="Edit"
              :disabled="single" 
              @click="handleUpdate"             
          >Edit</el-button>
        </el-col>
        <el-col :span="1.5">
          <el-button
              type="danger"
              plain
              icon="Delete"
              :disabled="multiple"
              @click="handleDelete"
          >Delete</el-button>
        </el-col>
        <right-toolbar></right-toolbar>
      </el-row>
  
      <!-- 数据展示表格 -->
      <el-table :data="productUnitList" @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="55" align="center" />
        <el-table-column label="Name" prop="name" width="200"/>
        <el-table-column prop="createTime" label="Create Time" />
        <el-table-column label="Operation" align="center" width="200" class-name="small-padding fixed-width">
          <template #default="scope">
            <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)">Edit</el-button>
            <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)">Delete</el-button>
          </template>
        </el-table-column>
      </el-table>
  
      <!-- 分页条组件 -->
      <pagination
          v-show="total > 0"
          :total="total"
      />

      <!-- 添加或修改商品单位对话框 -->
      <el-dialog :title="title" v-model="open" width="500px" append-to-body>
        <el-form ref="productUnitRef" :model="form" :rules="rules" label-width="100px">
          <el-form-item label="Unit Name" prop="name">
            <el-input v-model="form.name" placeholder="Please enter unit name" />
          </el-form-item>
        </el-form>
        <template #footer>
          <div class="dialog-footer">
            <el-button type="primary" @click="submitForm">Confrim</el-button>
            <el-button @click="cancel">Cancel</el-button>
          </div>
        </template>
      </el-dialog>
  
    </div>
</template>
  



<script setup name="ProductUnit">
import {listProductUnit,addProductUnit,updateProductUnit,getProductUnit,delProductUnit} from '@/api/base/productUnit'
import { ElMessage,ElMessageBox } from 'element-plus';
import { getCurrentInstance, onMounted } from 'vue';

const {proxy} = getCurrentInstance();
//定义分页列表数据模型
const productUnitList = ref([]);
//定义列表总记录数模型
const total = ref(2);
//加载数据时显示的动效控制模型
const loading = ref(true);

const data = reactive({
    form:{},
    queryParams:{
        name: null,
        pageNum: 1,
        pageSize: 10
    },
    rules:{
      name:[{required:true, message:"Product unit name is required", trigger:"blur"}]
    }  

})

const{queryParams, form, rules} =toRefs(data);

const open = ref(false);
const title = ref("");

const single = ref(true);
const multiple = ref(true);
const ids = ref([])
///////////////////////////////////////////function////////////////////////////////////

//////////分页查询//////////
const getList=()=>{
    loading.value = true;
    listProductUnit(queryParams.value).then(response=>{
        productUnitList.value = response.rows;
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
    getList();
}

/////////////新增/////////////
  // 表单重置
const reset=()=>{
  form.value.name = null;
  proxy.resetForm("productUnitRef");
}
// 新增按钮操作 
const handleAdd =()=>{
  reset();
  open.value = true;
  title.value = "Add Product Unit";
}

// 提交按钮
const submitForm =()=>{
  proxy.$refs["productUnitRef"].validate(valid=>{
    if(valid){
      if(form.value.id == null){
        addProductUnit(form.value).then(response=>{
          if(response.code === 200){
            proxy.$modal.msgSuccess("添加成功");
            open.value=false;
            getList();
          }else{
            proxy.$modal.msgError("添加失败");
          }
        })
      }else{
        updateProductUnit(form.value).then(response=>{
          if(response.code === 200){
            proxy.$modal.msgSuccess("修改成功");
            open.value=false;
            getList();
          }else{
            proxy.$modal.msgError("修改失败");
          }
        })
      }
    }else{
      proxy.$modal.msgError("校验失败");
    }
  })
}
// 取消按钮
const cancel =()=>{
  open.value = false;
  reset();
}
//////////////////////修改//////////////////////
const handleSelectionChange=(selection)=>{
  ids.value = selection.map(item=>{return item.id});
  const i = selection.length;
  single.value = i != 1;
  multiple.value = i === 0;
}

const handleUpdate=(row)=>{
  reset();
  const _ids = row.id || ids.value;
  getProductUnit(_ids).then(response=>{
    form.value = response.data;
    open.value = true;
    title.value = "Edit Product Unit";
  });
}
//////////////// 删除按钮操作//////////////////////////
const handleDelete=(row)=>{
  const _ids = row.id || ids.value;
  ElMessageBox.confirm(
    '是否确认删除编号为"' + _ids + '"的数据项？',
    "删除操作",
    {
      confirmButtonText: "确定",
      cancelButtonText: "取消",
      type: "warning",
    }
  ).then(()=>{
    delProductUnit(_ids).then(response=>{
      if(response.code === 200){
        proxy.$modal.msgSuccess("删除成功");
        open.value=false;
        getList();
      }else{
        proxy.$modal.msgError("删除失败");
      }
    })
  }).catch(()=>{
    proxy.$modal.msgError("删除失败");
  })
}




</script>