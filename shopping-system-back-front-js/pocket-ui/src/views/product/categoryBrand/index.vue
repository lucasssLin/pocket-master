<template>
    <div class="app-container">
      <el-form ref="queryRef" :inline="true" label-width="68px">
        <el-form-item label="Category">
          <el-cascader
              :props="categoryProps"
              style="width: 100%"
              v-model="queryParams.queryCategoryIds"
              @change="handleCategoryChange"
          />
        </el-form-item>
  
        <el-form-item label="Brand">
          <el-select
              v-model="queryParams.brandId"
              class="m-2"
              placeholder="选择品牌"
              size="small"
              style="width: 100%"
          >
            <el-option
                v-for="item in brandList"
                :key="item.id"
                :label="item.name"
                :value="item.id"
            />
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" icon="Search" @click="handleQuery">Search</el-button>
          <el-button icon="Refresh" id="reset-all" @click="resetQuery">Reset</el-button>
        </el-form-item>
      </el-form>
  
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
      <el-table :data="categoryBrandList" v-loading="loading" @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="55" align="center" />
        <el-table-column label="Category Name" prop="categoryName" />
        <el-table-column label="Brand Name" prop="brandName" />
        <el-table-column prop="logo" label="Brand Logo" #default="scope">
          <img :src="scope.row.logo" width="50" />
        </el-table-column>
        <el-table-column prop="createTime" label="Create Time" />
        <el-table-column label="Operation" align="center" class-name="small-padding fixed-width">
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
          v-model:page="queryParams.pageNum"
          v-model:limit="queryParams.pageSize"
          @pagination = "getList"
      />

      <!-- 添加或修改分类品牌对话框 -->
<el-dialog :title="title" v-model="open" :rules="rules" width="500px" append-to-body>
  <el-form ref="categoryBrandRef" :model="form" label-width="80px">
    <el-form-item label="Category" prop="categoryIdList">
      <el-cascader
          :props="categoryProps"
          v-model="form.categoryIdList"
          @change="handleFormCategoryChange"
      />
    </el-form-item>
    <el-form-item label="Brand" prop="brandId">
      <el-select
          v-model="form.brandId"
          class="m-2"
          placeholder="选择品牌"
          size="small"
      >
        <el-option
            v-for="item in form.brandList"
            :key="item.id"
            :label="item.name"
            :value="item.id"
        />
      </el-select>
    </el-form-item>
  </el-form>
  <template #footer>
    <div class="dialog-footer">
      <el-button type="primary" @click="submitForm">Confirm</el-button>
      <el-button @click="cancel">Cancel</el-button>
    </div>
  </template>
</el-dialog>
  
</div>
</template>
  



  <script setup name="CategoryBrand">
  // ================数据模型定义  start ===============================================
  import{listCategoryBrand,getBrandAll,addCategoryBrand,updateCategoryBrand,getCategoryBrand,delCategoryBrand} from "@/api/product/categoryBrand";
  import{getBrandAllBrand} from "@/api/product/brand";
  import {ref, reactive } from "vue";

  import { getTreeSelect } from "@/api/product/category";

  import { ElMessage, ElMessageBox } from "element-plus";
  import { getCurrentInstance } from "vue";
  // 定义搜索表单数据模型
  const brandList = ref([])
  
  const {proxy} = getCurrentInstance();

  
  // 定义表格数据模型
  const categoryBrandList = ref([])
  
  // 分页条数据模型
  const total = ref(2)
  
  const loading = ref(true);

  const data = reactive({
    queryParams:{
        categoryName:null,
        brandName:null,
        pageNum:1,
        pageSize:10,
        brandId: null,
        categoryId: 0,
        queryCategoryIds:[],
    },
    form:{
        categoryIdList:[],
        categoryId: 0,
        brandList:[]
    },
    rules: {
        categoryIdList: [
        { required: true, message: "分类不能为空", trigger: "blur" }
        ],
        brandId: [
        { required: true, message: "品牌不能为空", trigger: "blur" }
        ]
    }
  });
  const {queryParams,form,rules} = toRefs(data);


  const title = ref('');
  const open = ref(false);

  const single =ref(true);
  const multiple = ref(true);
  const ids = ref([])
  // =========================functions======================================================================
  
  /** 查询分类品牌列表 */
  const getList =()=>{
    loading.value = true;

    listCategoryBrand(queryParams.value).then(response=>{
        if(queryParams.value.queryCategoryIds){
            queryParams.value.categoryId = queryParams.value.queryCategoryIds[2];
        }
        categoryBrandList.value = response.rows;
        total.value = response.total;
        loading.value = false;
    })
  }

/** 获取分类数据*/
const props = {
    lazy: true,
    value: 'id',
    label: 'name',
    leaf: 'leaf',
    async lazyLoad(node, resolve) {   // 加载数据的方法
      if(typeof node.value == 'undefined'){
        node.value = 0;
      }
      const{data,code, message} = await getTreeSelect(node.value);
      
    //hasChildren判断是否有子节点
    data.forEach((item)=>{
        item.leaf = !item.hasChildren
    })
      resolve(data)// 返回数据
    }
  };
  const categoryProps = ref(props)

/** 获取分类下的brandList */
    const getBrandList=async()=>{
            getBrandAll(queryParams.value.categoryId).then(response=>{
            if(response.code === 200){
                brandList.value = response.data;
            }
        })
    }
    
const handleCategoryChange = () => {
    if(queryParams.value.queryCategoryIds.length === 3){
        queryParams.value.categoryId = queryParams.value.queryCategoryIds[2];
    // 可以在这里处理分类变化的逻辑
        getBrandList(); // 调用获取品牌列表的方法
    }    
};
    
/** 搜索按钮操作 */
  const handleQuery=()=>{
    queryParams.value.pageNum = 1;
    getList();
  }

  /** 重置按钮操作 */
  const resetQuery=()=>{
    queryParams.value.categoryId = 0;
    queryParams.value.brandId = null;
    queryParams.value.queryCategoryIds = [];
    proxy.resetForm("queryRef");
    getBrandList();
    getList();
  }

  // 表单重置
  const resetForm=()=>{
    form.value = {
    id: null,
    brandId: null,
    categoryId: null,
    categoryIdList: []
    };
    proxy.resetForm("categoryBrandRef");
    
  }

  /** 新增按钮操作 */
  const handleAdd=()=>{
    resetForm();
    getFormBrandList();
    open.value = true;
    title.value = "Add CategoryBrand";
  }

    /** 提交按钮 */
    const submitForm=()=>{
    proxy.$refs["categoryBrandRef"].validate(valid=>{
        if(valid){
            form.value.categoryId = form.value.categoryIdList[2];
            if(form.value.id == null){
                addCategoryBrand(form.value).then(response=>{
                    if(response.code ===200){
                        proxy.$modal.msgSuccess("新增成功");
                        open.value = false;
                        getList();
                    }else{
                    ElMessage.error(response.msg);
                    }

                })
            }else{
                updateCategoryBrand(form.value).then(response=>{
                    if(response.code ===200){
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
// 取消按钮
const cancel =()=>{
    open.value = false;
    resetForm();
}

// 多选框选中数据
const handleSelectionChange =(selection)=>{
    ids.value=selection.map(item=>{return item.id});
    const i = selection.length
    single.value = i != 1;
    multiple.value = i === 0;
}


/** 获取form下的分类下的brandList */
const getFormBrandList=async()=>{
            getBrandAllBrand().then(response=>{
            if(response.code === 200){
                form.value.brandList = response.data;
            }
        })
}
    
// const handleFormCategoryChange = () => {
//     if(form.value.categoryIdList.length === 3){
//         form.value.categoryId = form.value.categoryIdList[2];
//     // 可以在这里处理分类变化的逻辑
//     getFormBrandList(); // 调用获取品牌列表的方法
//     }    
// };

/** 修改按钮操作 */
 const handleUpdate=(row)=>{
    resetForm();
    const _ids = row.id || ids.value;
    
    getCategoryBrand(_ids).then(response=>{
        form.value = response.data;
        open.value = true;
        title.value = "Edit CategoryBrand";
        getFormBrandList();
    })
 }


 /** 删除按钮操作 */
 const handleDelete=(row)=>{
    const _ids = row.id || ids.value;
    ElMessageBox.confirm(
    '是否确认删除分类品牌编号为"' + _ids + '"的数据项？',
    "删除操作",
    {
      confirmButtonText: "确定",
      cancelButtonText: "取消",
      type: "warning",
    }
    ).then(response=>{
        delCategoryBrand(_ids).then(response=>{
            if(response.code === 200){
                getList();
                proxy.$modal.msgSuccess("删除成功");
            }
        }).catch(response=>{
            proxy.$modal.msgError(response.msg);
        })
    })
 }


onMounted(()=>{
    getList();
    // getBrandList();
  })

</script>