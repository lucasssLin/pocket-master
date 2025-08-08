<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="120px">
      <el-form-item label="Product Name" prop="name">
        <el-input
          v-model="queryParams.name"
          placeholder="Please enter product name"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="Brand">
        <el-select
          v-model="queryParams.brandId"
          class="m-2"
          placeholder="Select Brand"
          size="small"
          style="width: 100%"
        >
          <el-option
            v-for="item in queryBrandList"
            :key="item.id"
            :label="item.name"
            :value="item.id"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="Category">
        <el-select
          v-model="queryParams.category1Id"
          @change="selectCategory1"
          class="m-2"
          placeholder="1st Category"
          size="small"
          style="width: 48%;margin-right: 5px;"
        >
          <el-option
            v-for="item in queryCategory1List"
            :key="item.id"
            :label="item.name"
            :value="item.id"
          />
        </el-select>
        <el-select
          v-model="queryParams.category2Id"
          class="m-2"
          placeholder="2nd Category"
          size="small"
          style="width: 48%;"
        >
          <el-option
            v-for="item in queryCategory2List"
            :key="item.id"
            :label="item.name"
            :value="item.id"
          />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">Search</el-button>
        <el-button icon="Refresh" @click="resetQuery">Reset</el-button>
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
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="productList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column prop="id" label="ID" width="60"/>
      <el-table-column label="Slideshow" #default="scope" width="200">
        <div style="height: 50px;float: left;">
          <img v-for="(item, index) in scope.row.sliderUrlList"
            :key="index"
            :src="item"
            width="50"
          />
        </div>
      </el-table-column>
      <el-table-column prop="name" label="Product Name" width="160" />
      <el-table-column prop="brandName" label="Brand" />
      <el-table-column prop="category1Name" label="1st Category" />
      <el-table-column prop="category2Name" label="2nd Category" />
      <el-table-column prop="unitName" label="Price Unit" />
      <el-table-column prop="status" label="Status" #default="scope">
        {{ scope.row.status == 0 ? 'Not Listed' : scope.row.status == 1 ? 'Online' : 'Offline' }}
      </el-table-column>
      <el-table-column prop="auditStatus" label="Audit Status" #default="scope">
        {{ scope.row.auditStatus == 0 ? 'Not Audited' : scope.row.auditStatus == 1 ? 'Pass' : 'Reject' }}
      </el-table-column>
      <el-table-column label="Operation" align="center" class-name="small-padding fixed-width" width="250">
        <template #default="scope">
          <el-button v-if="scope.row.auditStatus == 0" link type="primary" icon="Edit" @click="handleUpdate(scope.row)">Edit</el-button>
          <el-button v-if="scope.row.auditStatus == 0" link type="primary" icon="Delete" @click="handleDelete(scope.row)">Delete</el-button>
          <el-button v-if="scope.row.auditStatus == 0" link type="success" @click="handleAudit(scope.row.id, 1)">Pass</el-button>
          <el-button v-if="scope.row.auditStatus == 0" link type="danger" @click="handleAudit(scope.row.id, -1)">Reject</el-button>
          <el-button v-if="scope.row.auditStatus == 1 && (scope.row.status == 0 || scope.row.status == -1)" link type="primary" @click="handleUpdateStatus(scope.row.id, 1)">Online</el-button>
          <el-button v-if="scope.row.auditStatus == 1 && scope.row.status == 1" link type="primary" plain @click="handleUpdateStatus(scope.row.id, -1)">Offline</el-button>
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

    <!-- Add or Edit Product Dialog -->
    <el-dialog :title="title" v-model="open" width="60%" append-to-body>
      <el-steps :active="activeIndex" finish-status="success">
        <el-step title="Step 1" description="Product Basic Info"></el-step>
        <el-step title="Step 2" description="Product Specifications"></el-step>
        <el-step title="Step 3" description="Product SKU Info"></el-step>
        <el-step title="Step 4" description="Product Detail Info"></el-step>
      </el-steps>
      <el-form ref="productRef" :model="form" :rules="rules" label-width="120px" style="margin-top: 20px;">
        <el-divider />
        <!-- Step 1: Basic Product Information -->
        <div v-if="activeIndex == 0">
          <el-form-item label="Product Name" prop="name">
            <el-input v-model="form.name" placeholder="Enter product name" />
          </el-form-item>
          <el-form-item label="Product Description" prop="description">
            <el-input type="textarea" v-model="form.description" placeholder="Enter product description" rows="3" />
          </el-form-item>
          <el-form-item label="Category" prop="category2Id">
            <el-select
              v-model="form.category1Id"
              @change="handleCategory1Change"
              class="m-2"
              placeholder="Select 1st category"
              style="width: 48%; margin-right: 4%"
            >
              <el-option
                v-for="item in categoryList"
                :key="item.id"
                :label="item.name"
                :value="item.id"
              />
            </el-select>
            <el-select
              v-model="form.category2Id"
              class="m-2"
              placeholder="Select 2nd category"
              style="width: 48%"
            >
              <el-option
                v-for="item in category2List"
                :key="item.id"
                :label="item.name"
                :value="item.id"
              />
            </el-select>
          </el-form-item>
          <el-form-item label="Brand" prop="brandId">
            <el-select v-model="form.brandId" class="m-2" placeholder="Select Brand" style="width: 100%">
              <el-option
                v-for="item in categoryBrandList"
                :key="item.id"
                :label="item.name"
                :value="item.id"
              />
            </el-select>
          </el-form-item>
          <el-form-item label="Product Unit" prop="unitName">
            <el-select
              v-model="form.unitName"
              class="m-2"
              placeholder="Product Unit"
              style="width: 100%"
            >
              <el-option
                v-for="item in unitList"
                :key="item.id"
                :label="item.name"
                :value="item.name"
              />
            </el-select>
          </el-form-item>
          <el-form-item label="Slideshow" prop="sliderUrlList">
            <el-upload
              v-model:file-list="sliderTempUrlList"
              :action="imgUpload.url"
              :headers="imgUpload.headers"
              list-type="picture-card"
              multiple
              :on-success="handleSliderSuccess"
              :on-remove="handleRemove"
            >
              <el-icon><Plus /></el-icon>
            </el-upload>
          </el-form-item>
        </div>
        
        <!-- Step 2: Product Specifications -->
        <div v-if="activeIndex == 1">
          <el-form-item label="Product Specifications" prop="specsList">
            <div v-for="(spec, specIndex) in form.specsList" :key="specIndex" class="spec-item">
              <el-divider v-if="specIndex > 0" />
              <div class="spec-header">
                <el-input 
                  v-model="spec.specName" 
                  placeholder="Specification Name (e.g. Color, Size)" 
                  style="width: 300px"
                />
                <el-button 
                  v-if="specIndex > 0" 
                  type="danger" 
                  icon="Delete" 
                  circle 
                  @click="removeSpec(specIndex)"
                  style="margin-left: 10px"
                />
              </div>
              <div class="spec-values">
                <div v-for="(value, valueIndex) in spec.values" :key="valueIndex" class="spec-value-item">
                  <el-input
                    v-model="value.name"
                    placeholder="Value (e.g. Red, Large)"
                    style="width: 200px; margin-right: 10px; margin-top: 10px"
                  />
                  <el-input
                    v-model="value.valueDesc"
                    placeholder="Description (optional)"
                    style="width: 200px; margin-right: 10px; margin-top: 10px"
                  />
                  <el-upload
                    class="spec-image-uploader"
                    :action="imgUpload.url"
                    :headers="imgUpload.headers"
                    :show-file-list="false"
                    :on-success="(response) => handleSpecValueImageSuccess(response, spec, value)"
                  >
                    <img
                      v-if="value.picture"
                      :src="value.picture"
                      class="spec-image"
                    />
                    <el-icon v-else class="spec-image-uploader-icon"><Plus /></el-icon>
                  </el-upload>
                  <el-button 
                    v-if="valueIndex > 0" 
                    type="danger" 
                    icon="Delete" 
                    circle 
                    @click="removeSpecValue(spec, valueIndex)"
                    style="margin-top: 10px"
                  />
                </div>
                <el-button 
                  type="primary" 
                  plain 
                  icon="Plus" 
                  @click="addSpecValue(spec)" 
                  style="margin-top: 10px"
                >Add Value</el-button>
              </div>
            </div>
            <div style="margin-top: 15px">
              <el-button type="success" plain icon="Plus" @click="addSpec">Add Specification</el-button>
            </div>
          </el-form-item>
        </div>
        
        <!-- Step 3: Product SKU Information -->
        <div v-if="activeIndex == 2">
          <el-alert
            title="Product SKUs will be generated based on the specifications you defined in the previous step."
            type="info"
            :closable="false"
            style="margin-bottom: 15px"
          />
          <el-button type="primary" @click="generateSkus" style="margin-bottom: 15px">Generate SKU Combinations</el-button>
          
          <el-form-item label="Product SKUs">
            <el-table :data="form.productSkuList" border style="width: 100%">
              <el-table-column prop="skuSpec" label="Specification" width="180" />
              <el-table-column label="Photo" #default="scope" width="80">
                <el-upload
                  class="avatar-uploader"
                  :action="imgUpload.url"
                  :headers="imgUpload.headers"
                  :show-file-list="false"
                  :on-success="(response) => handleSkuSuccess(response, scope.row)">
                  <img
                    v-if="scope.row.thumbImg"
                    :src="scope.row.thumbImg"
                    class="avatar"
                  />
                  <el-icon v-else class="avatar-uploader-icon"><Plus /></el-icon>
                </el-upload>
              </el-table-column>
              <el-table-column label="Sales Price" #default="scope">
                <el-input v-model="scope.row.salePrice" placeholder="0.00" />
              </el-table-column>
              <el-table-column label="Market Price" #default="scope">
                <el-input v-model="scope.row.marketPrice" placeholder="0.00" />
              </el-table-column>
              <el-table-column label="Cost Price" #default="scope">
                <el-input v-model="scope.row.costPrice" placeholder="0.00" />
              </el-table-column>
              <el-table-column label="Stock Number" #default="scope">
                <el-input v-model="scope.row.stockNum" placeholder="0" />
              </el-table-column>
              <el-table-column label="Weight" #default="scope">
                <el-input v-model="scope.row.weight" placeholder="0.00" />
              </el-table-column>
              <el-table-column label="Volume" #default="scope">
                <el-input v-model="scope.row.volume" placeholder="0.00" />
              </el-table-column>
            </el-table>
          </el-form-item>
        </div>
        
        <!-- Step 4: Product Details -->
        <div v-if="activeIndex == 3">
          <el-form-item label="Detail Images">
            <el-upload
              v-model:file-list="detailsImageTempUrlList"
              :action="imgUpload.url"
              :headers="imgUpload.headers"
              list-type="picture-card"
              multiple
              :on-success="handleDetailsSuccess"
              :on-remove="handleDetailsRemove"
            >
              <el-icon><Plus /></el-icon>
            </el-upload>
          </el-form-item>
          
          <el-form-item label="Product Properties">
            <el-input
              type="textarea"
              v-model="form.productDetails.properties"
              placeholder="Enter product properties in JSON format"
              rows="5"
            />
          </el-form-item>
        </div>
        
        <!-- Step 5: Success -->
        <div v-if="activeIndex == 4">
          <div style="font-size: large; margin: 30px 30px; text-align: center;">
            <el-icon style="font-size: 48px; color: #67C23A; margin-bottom: 20px;"><Check /></el-icon>
            <div>Product Successfully Submitted!</div>
          </div>
        </div>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="danger" @click="prevStep" :disabled="activeIndex == 0">Previous</el-button>
          <el-button type="primary" @click="nextStep">{{ activeIndex < 3 ? 'Next' : 'Submit' }}</el-button>
          <el-button @click="cancel">Cancel</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="Product">
import { ref, reactive, toRefs, getCurrentInstance } from 'vue';
import { listProduct, getProduct, delProduct, addProduct, updateProduct, updateStatus, updateAuditStatus } from "@/api/product/product";
import { getTreeSelect } from "@/api/product/category";
import { getCategoryBrandAll } from "@/api/product/categoryBrand";
import { getBrandAll } from "@/api/product/brand";
import { getUnitAll } from "@/api/base/productUnit";
import { getCategorySpecAll } from "@/api/product/productSpec";
import { getToken } from "@/utils/auth.js";
import { Plus, Check } from '@element-plus/icons-vue';

const { proxy } = getCurrentInstance();

const productList = ref([]);
const open = ref(false);
const loading = ref(true);
const showSearch = ref(true);
const ids = ref([]);
const single = ref(true);
const multiple = ref(true);
const total = ref(0);
const title = ref("");

const data = reactive({
  form: {
    // 基本字段，对应 Product.java 类的属性
    id: null,
    name: null,
    brandId: null,
    category1Id: null,
    category2Id: null,
    unitName: null,
    sliderUrls: null,
    specValue: null,
    status: 0,
    auditStatus: 0,
    auditMessage: null,
    description: null,
    
    // 扩展字段，用于 UI 交互
    sliderUrlList: [],
    detailsImageUrlList: [],
    
    // 关联实体
    productSkuList: [], // 对应 ProductSku.java
    specsList: [], // 对应 ProductSpecs.java
    productDetails: { // 对应 ProductDetails.java
      productId: null,
      imageUrls: "",
      properties: "{}"
    }
  },
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    name: null,
    brandId: null,
    category1Id: null,
    category2Id: null,
    status: null,
    auditStatus: null
  },
  rules: {
    name: [
      { required: true, message: "Product name cannot be empty", trigger: "change" }
    ],
    category2Id: [
      { required: true, message: "Product category cannot be empty", trigger: "change" }
    ],
    brandId: [
      { required: false, message: "Brand name cannot be empty", trigger: "change" }
    ],
    unitName: [
      { required: false, message: "Product unit cannot be empty", trigger: "change" }
    ],
    sliderUrlList: [
      { required: true, message: "Slideshow cannot be empty", trigger: "change" }
    ]
  },
  imgUpload: {
    // Set upload request headers
    headers: {
      Authorization: "Bearer " + getToken()
    },
    // Image upload URL:
    url: "http://192.168.1.12:8080/file/upload/minio"
  }
});

const { queryParams, form, rules, imgUpload } = toRefs(data);

// Initialize data
getList();

/** Query product list */
function getList() {
  loading.value = true;
  listProduct(queryParams.value).then(response => {
    productList.value = response.rows;
    productList.value.forEach(item => {
      item.sliderUrlList = item.sliderUrls ? item.sliderUrls.split(',') : []
    })
    total.value = response.total;
    loading.value = false;
  });
}

// Cancel button
function cancel() {
  open.value = false;
  reset();
}

// 重置表单，与 Product.java 结构保持一致
function reset() {
  form.value = {
    // 基本字段，对应 Product.java 类的属性
    id: null,
    name: null,
    brandId: null,
    category1Id: null,
    category2Id: null,
    unitName: null,
    sliderUrls: null,
    specValue: null,
    status: 0,
    auditStatus: 0,
    auditMessage: null,
    description: null,
    
    // 扩展字段，用于 UI 交互
    sliderUrlList: [],
    detailsImageUrlList: [],
    
    // 关联实体
    productSkuList: [], // 对应 ProductSku.java
    specsList: [{  // 对应 ProductSpecs.java
      specName: "",
      categoryId: null,
      values: [{  // 对应 ProductSpecValues.java
        name: "",
        valueDesc: "",
        picture: "",
        isAvailable: true
      }]
    }],
    productDetails: { // 对应 ProductDetails.java
      productId: null,
      imageUrls: "",
      properties: "{}"
    }
  };
  
  // 重置表单验证状态
  proxy.resetForm("productRef");
  
  // 重置上传组件
  sliderTempUrlList.value = [];
  detailsImageTempUrlList.value = [];
}

/** Search button operation */
function handleQuery() {
  queryParams.value.pageNum = 1;
  getList();
}

/** Reset button operation */
function resetQuery() {
  queryCategory2List.value = [];
  proxy.resetForm("queryRef");
  queryParams.value.category1Id = null;
  queryParams.value.category2Id = null;
  queryParams.value.brandId = null;
  handleQuery();
}

// Checkbox selection change
function handleSelectionChange(selection) {
  ids.value = selection.map(item => item.id);
  single.value = selection.length != 1;
  multiple.value = !selection.length;
}

// Category search
const queryCategory1List = ref([]);
const queryCategory2List = ref([]);
const getTreeSelectList = async (parentId, level) => {
  const { code, data, message } = await getTreeSelect(parentId);
  if (level == 1) {
    queryCategory1List.value = data;
  }
  if (level == 2) {
    queryCategory2List.value = data;
  }
};

const selectCategory1 = () => {
  queryCategory2List.value = [];
  getTreeSelectList(queryParams.value.category1Id, 2);
};

getTreeSelectList(0, 1);

// Brand search
const queryBrandList = ref([]);
const getBrandAllList = async () => {
  const { data } = await getBrandAll();
  queryBrandList.value = data;
};
getBrandAllList();

/** Add button operation */
function handleAdd() {
  reset();
  open.value = true;
  title.value = "Add Product";
  
  // Initialize
  activeIndex.value = 0;
  sliderTempUrlList.value = [];
  detailsImageTempUrlList.value = [];
  
  // Initialize specs with one default spec
  form.value.specsList = [{
    specName: "",
    values: [{
      name: "",
      valueDesc: "",
      picture: "",
      isAvailable: true
    }]
  }];
  
  // Load category and unit data
  getTreeSelectList(0, 1);
  getUnitAllList();
}

/** Edit button operation */
function handleUpdate(row) {
  reset();
  const _id = row.id || ids.value;
  getProduct(_id).then(response => {
    // 获取到的数据可能与表单结构不完全匹配，需要处理
    const productData = response.data;
    
    // 基本字段赋值
    form.value.id = productData.id;
    form.value.name = productData.name;
    form.value.description = productData.description;
    form.value.brandId = productData.brandId;
    form.value.category1Id = productData.category1Id;
    form.value.category2Id = productData.category2Id;
    form.value.unitName = productData.unitName;
    form.value.status = productData.status;
    form.value.auditStatus = productData.auditStatus;
    form.value.auditMessage = productData.auditMessage;
    
    // 处理轮播图
    form.value.sliderUrls = productData.sliderUrls;
    form.value.sliderUrlList = productData.sliderUrls ? productData.sliderUrls.split(",") : [];
    sliderTempUrlList.value = form.value.sliderUrlList.map(url => ({ url }));
    
    // 处理SKU列表
    form.value.productSkuList = productData.productSkuList || [];
    
    // 处理规格列表
    form.value.specsList = productData.specsList || [];
    
    // 如果没有规格列表，初始化一个默认规格
    if (!form.value.specsList.length) {
      form.value.specsList = [{
        specName: "",
        categoryId: form.value.category2Id,
        values: [{
          name: "",
          valueDesc: "",
          picture: "",
          isAvailable: true
        }]
      }];
    }
    
    // 处理商品详情
    if (productData.productDetails) {
      form.value.productDetails = productData.productDetails;
      
      // 处理详情图片
      if (productData.productDetails.imageUrls) {
        form.value.detailsImageUrlList = productData.productDetails.imageUrls.split(",");
        detailsImageTempUrlList.value = form.value.detailsImageUrlList.map(url => ({ url }));
      }
    }
    
    open.value = true;
    title.value = "编辑商品";
    activeIndex.value = 0;

    // 加载分类相关数据
    if (form.value.category1Id) {
      getTreeSelectList(form.value.category1Id, 2);
    }
    
    // 加载品牌数据
    getCategoryBrand();
    
    console.log("编辑商品表单数据:", form.value);
  }).catch(error => {
    console.error("获取商品数据失败:", error);
    proxy.$modal.msgError("获取商品数据失败");
  });
}

// Step navigation
const activeIndex = ref(0);

function prevStep() {
  activeIndex.value--;
  if (activeIndex.value < 0) activeIndex.value = 0;
}

function nextStep() {
  proxy.$refs["productRef"].validate(valid => {
    if (valid) {
      if (activeIndex.value === 3) {
        submitForm();
      } else {
        activeIndex.value++;
      }
    }
  });
}

function submitForm() {
  // 准备提交的数据对象，确保与后端实体结构一致
  // 这里的结构必须完全符合后端 Product.java 及相关实体类的要求
  
  // 1. 首先处理图片URL
  const sliderUrls = form.value.sliderUrlList.join(',');
  const detailsImageUrls = form.value.detailsImageUrlList.join(',');
  
  // 2. 确保规格列表中所有对象的结构正确
  const specsList = form.value.specsList.map(spec => ({
    specName: spec.specName,
    categoryId: form.value.category2Id,
    productId: null,  // 新增时为null
    values: spec.values.map(val => ({
      name: val.name,
      valueDesc: val.valueDesc || "",
      picture: val.picture || "",
      isAvailable: true
    }))
  }));
  
  // 3. 构建最终的提交对象
  const productData = {
    id: form.value.id,  // 编辑时有值，新增时为null
    name: form.value.name,
    description: form.value.description,
    brandId: form.value.brandId,
    category1Id: form.value.category1Id,
    category2Id: form.value.category2Id,
    unitName: form.value.unitName,
    status: form.value.status,
    auditStatus: form.value.auditStatus,
    auditMessage: form.value.auditMessage,
    sliderUrls: sliderUrls,
    productSkuList: form.value.productSkuList,
    specsList: specsList,
    productDetails: {
      productId: null,  // 新增时为null
      imageUrls: detailsImageUrls,
      properties: form.value.productDetails.properties || "{}"
    }
  };
  
  console.log("提交到后端的数据结构:", JSON.stringify(productData));
  
  if (form.value.id != null) {
    // 编辑模式，需要保留ID
    productData.specsList.forEach(spec => {
      spec.productId = form.value.id;
    });
    productData.productDetails.productId = form.value.id;
    productData.productSkuList.forEach(sku => {
      sku.productId = form.value.id;
    });
    
    updateProduct(productData).then(response => {
      proxy.$modal.msgSuccess("修改成功");
      // 移动到成功界面
      activeIndex.value = 4;
      setTimeout(() => {
        open.value = false;
        getList();
      }, 2000);
    }).catch(error => {
      console.error("更新产品失败:", error);
      proxy.$modal.msgError("更新产品失败，请检查数据格式是否正确");
    });
  } else {
    // 新增模式，ID字段为null
    addProduct(productData).then(response => {
      proxy.$modal.msgSuccess("添加成功");
      // 移动到成功界面
      activeIndex.value = 4;
      setTimeout(() => {
        open.value = false;
        getList();
      }, 2000);
    }).catch(error => {
      console.error("添加产品失败:", error);
      proxy.$modal.msgError("添加产品失败，请检查数据格式是否正确");
    });
  }
}

/** Delete button operation */
function handleDelete(row) {
  const _ids = row.id || ids.value;
  proxy.$modal.confirm('Are you sure you want to delete product ID "' + _ids + '"?').then(function() {
    return delProduct(_ids);
  }).then(() => {
    getList();
    proxy.$modal.msgSuccess("Delete successful");
  }).catch(() => {});
}

// Audit product
function handleAudit(id, status) {
  const msg = status == 1 ? 'Are you sure you want to approve product ID "' + id + '"?' : 'Are you sure you want to reject product ID "' + id + '"?';
  proxy.$modal.confirm(msg).then(function() {
    return updateAuditStatus(id, status);
  }).then(() => {
    // 审核成功后，如果是通过审核，自动设置为上架状态
    if (status == 1) {
      // 审核通过后自动上架
      return updateStatus(id, 1);
    }
    // 如果是拒绝审核，不做状态更新
    return Promise.resolve();
  }).then(() => {
    getList();
    if (status == 1) {
      proxy.$modal.msgSuccess("审核通过并已自动上架");
    } else {
      proxy.$modal.msgSuccess("审核拒绝成功");
    }
  }).catch((error) => {
    console.error("操作失败:", error);
    proxy.$modal.msgError("操作失败，请重试");
  });
}

// Update product status (online/offline)
function handleUpdateStatus(id, status) {
  const msg = status == 1 ? 'Are you sure you want to set product ID "' + id + '" online?' : 'Are you sure you want to set product ID "' + id + '" offline?';
  proxy.$modal.confirm(msg).then(function() {
    return updateStatus(id, status);
  }).then(() => {
    getList();
    proxy.$modal.msgSuccess("Operation successful");
  }).catch(() => {});
}

// Category handling
const categoryList = ref([]);
const category2List = ref([]);
const loadCategories = async () => {
  const { data } = await getTreeSelect(0);
  categoryList.value = data;
};
loadCategories();

const handleCategory1Change = () => {
  form.value.category2Id = null;
  loadCategory2List();
  getCategoryBrand();
};

const loadCategory2List = async () => {
  if (!form.value.category1Id) return;
  const { data } = await getTreeSelect(form.value.category1Id);
  category2List.value = data;
};

// Load units
const unitList = ref([]);
const getUnitAllList = async () => {
  const { data } = await getUnitAll();
  unitList.value = data;
};

// Slideshow image handling
const sliderTempUrlList = ref([]);
const handleRemove = (uploadFile) => {
  form.value.sliderUrlList = form.value.sliderUrlList.filter(url => url !== uploadFile.url);
};
const handleSliderSuccess = (response) => {
  if(response.code == 200) {
    form.value.sliderUrlList.push(response.data.url);
  } else {
    proxy.$modal.msgError(response.msg);
  }
};

// SKU image handling
const handleSkuSuccess = (response, row) => {
  if(response.code == 200) {
    row.thumbImg = response.data.url;
  } else {
    proxy.$modal.msgError(response.msg);
  }
};

// Load category brands
const categoryBrandList = ref([]);
const getCategoryBrand = async () => {
  if (!form.value.category2Id) return;
  
  try {
    const { data } = await getCategoryBrandAll(form.value.category2Id);
    categoryBrandList.value = data;
  } catch (error) {
    console.error("Error loading category brands:", error);
    categoryBrandList.value = [];
  }
};

// Specification management
const addSpec = () => {
  form.value.specsList.push({
    specName: "",
    values: [{
      name: "",
      valueDesc: "",
      picture: "",
      isAvailable: true
    }]
  });
};

const removeSpec = (index) => {
  form.value.specsList.splice(index, 1);
};

const addSpecValue = (spec) => {
  spec.values.push({
    name: "",
    valueDesc: "",
    picture: "",
    isAvailable: true
  });
};

const removeSpecValue = (spec, index) => {
  spec.values.splice(index, 1);
};

const handleSpecValueImageSuccess = (response, spec, value) => {
  if(response.code == 200) {
    value.picture = response.data.url;
  } else {
    proxy.$modal.msgError(response.msg);
  }
};

// 生成 SKUs 基于规格
const generateSkus = () => {
  // 清空现有 SKUs
  form.value.productSkuList = [];
  
  // 验证规格信息
  if (!form.value.specsList || form.value.specsList.length === 0) {
    proxy.$modal.msgError("请添加至少一个规格");
    return;
  }
  
  // 检查规格是否有值
  const invalidSpecs = form.value.specsList.filter(spec => 
    !spec.specName || 
    !spec.values || 
    spec.values.length === 0 || 
    spec.values.some(v => !v.name)
  );
  
  if (invalidSpecs.length > 0) {
    proxy.$modal.msgError("所有规格必须有名称和至少一个值");
    return;
  }
  
  // 准备笛卡尔积计算
  const specArray = form.value.specsList.map(spec => {
    return {
      specName: spec.specName,
      values: spec.values.map(val => ({
        name: val.name,
        picture: val.picture || (form.value.sliderUrlList[0] || '')
      }))
    };
  });
  
  // 生成所有组合（笛卡尔积）
  const cartesianProduct = (arr) => {
    return arr.reduce((a, b) => {
      return a.flatMap(x => b.values.map(y => [...x, { spec: b.specName, value: y.name, picture: y.picture }]));
    }, [[]]);
  };
  
  const combinations = cartesianProduct(specArray);
  
  // 为每个组合创建 SKUs，确保符合 ProductSku.java 的结构
  combinations.forEach((combo, index) => {
    // 跳过空组合（无规格时发生）
    if (combo.length === 0) return;
    
    // 格式化规格展示文本
    const specText = combo.map(item => `${item.value}`).join(' + ');
    
    // 创建新的 SKU，确保字段与 ProductSku.java 一致
    const newSku = {
      skuCode: "", // 后端会根据 product id 和索引生成
      skuName: form.value.name + " " + specText, // 根据 ProductServiceImpl.newInsertProduct 中的逻辑
      productId: null, // 新增时为 null，将由后端设置
      thumbImg: combo[0].picture || '', // 使用第一个规格值的图片作为默认
      salePrice: "", // 销售价格
      marketPrice: "", // 市场价格
      costPrice: "", // 成本价格
      skuSpec: specText, // 规格信息
      weight: "", // 重量
      volume: "", // 体积
      status: 0, // 状态
      stockNum: 0 // 库存数量，UI 专用字段
    };
    
    form.value.productSkuList.push(newSku);
  });
  
  if (form.value.productSkuList.length === 0) {
    proxy.$modal.msgError("生成 SKUs 失败。请检查您的规格信息。");
  } else {
    proxy.$modal.msgSuccess(`成功生成 ${form.value.productSkuList.length} 个 SKUs`);
  }
};

// Detail images handling
const detailsImageTempUrlList = ref([]);
const handleDetailsRemove = (uploadFile) => {
  form.value.detailsImageUrlList = form.value.detailsImageUrlList.filter(url => url !== uploadFile.url);
};
const handleDetailsSuccess = (response) => {
  if(response.code == 200) {
    form.value.detailsImageUrlList.push(response.data.url);
  } else {
    proxy.$modal.msgError(response.msg);
  }
};
</script>

<style>
.avatar-uploader .el-upload {
  border: 1px dashed var(--el-border-color);
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
  transition: var(--el-transition-duration-fast);
  width: 70px;
  height: 70px;
}

.avatar-uploader .el-upload:hover {
  border-color: var(--el-color-primary);
}

.el-icon.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 50px;
  height: 50px;
  text-align: center;
}

.spec-image-uploader .el-upload {
  border: 1px dashed var(--el-border-color);
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
  transition: var(--el-transition-duration-fast);
  width: 60px;
  height: 60px;
  display: inline-flex;
  justify-content: center;
  align-items: center;
  vertical-align: top;
  margin-top: 10px;
}

.spec-image-uploader .el-upload:hover {
  border-color: var(--el-color-primary);
}

.spec-image {
  width: 58px;
  height: 58px;
  object-fit: cover;
}

.spec-image-uploader-icon {
  font-size: 24px;
  color: #8c939d;
  width: 60px;
  height: 60px;
  text-align: center;
  display: flex;
  justify-content: center;
  align-items: center;
}

.spec-item {
  margin-bottom: 15px;
  padding-bottom: 15px;
}

.spec-header {
  display: flex;
  align-items: center;
  margin-bottom: 10px;
}

.spec-values {
  margin-left: 20px;
}

.spec-value-item {
  display: flex;
  align-items: center;
}
</style>