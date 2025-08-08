<template>
    <div class="app-container">
      <!-- Search Form -->
      <el-form ref="queryForm" :model="queryParams" :inline="true" label-width="120px">
        <el-form-item label="Product ID" prop="productId">
          <el-input
            v-model="queryParams.productId"
            placeholder="Enter product ID"
            clearable
            style="width: 240px"
            @keyup.enter="handleQuery"
          />
        </el-form-item>
        <el-form-item label="Specification" prop="specName">
          <el-input
            v-model="queryParams.specName"
            placeholder="Enter specification name"
            clearable
            style="width: 240px"
            @keyup.enter="handleQuery"
          />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" icon="Search" @click="handleQuery">Search</el-button>
          <el-button icon="Refresh" @click="resetQuery">Reset</el-button>
        </el-form-item>
      </el-form>
  
      <!-- Operation Buttons -->
      <el-row :gutter="10" class="mb8">
        <el-col :span="1.5">
          <el-button type="primary" icon="Plus" @click="handleAdd">Add</el-button>
        </el-col>
        <el-col :span="1.5">
          <el-button type="success" icon="Edit" :disabled="single" @click="handleUpdate">Edit</el-button>
        </el-col>
        <el-col :span="1.5">
          <el-button type="danger" icon="Delete" :disabled="multiple" @click="handleDelete">Delete</el-button>
        </el-col>
        <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
      </el-row>
  
      <!-- Data Table -->
      <el-table
        v-loading="loading"
        :data="specList"
        @selection-change="handleSelectionChange"
      >
        <el-table-column type="selection" width="55" align="center" />
        <el-table-column label="Product ID" prop="productId" min-width="120" />
        <el-table-column label="Specification" prop="specName" min-width="150" show-overflow-tooltip />
        <el-table-column label="Specification Values" min-width="280">
          <template #default="scope">
            <!-- If specValue is a single object -->
            <template v-if="scope.row.parsedSpecValue && !Array.isArray(scope.row.parsedSpecValue)">
              <div class="spec-item">
                <div class="spec-values">
                  <el-tag
                    v-for="(value, vIndex) in scope.row.parsedSpecValue.valueList"
                    :key="vIndex"
                    class="spec-value-tag"
                    type="info"
                    effect="plain"
                  >
                    {{ value }}
                  </el-tag>
                </div>
              </div>
            </template>
            
            <!-- If specValue is an array of objects -->
            <template v-else-if="Array.isArray(scope.row.parsedSpecValue)">
              <div v-for="(spec, index) in scope.row.parsedSpecValue" :key="index" class="spec-item">
                <div class="spec-key">{{ spec.key }}:</div>
                <div class="spec-values">
                  <el-tag
                    v-for="(value, vIndex) in spec.valueList"
                    :key="vIndex"
                    class="spec-value-tag"
                    type="info"
                    effect="plain"
                  >
                    {{ value }}
                  </el-tag>
                </div>
              </div>
            </template>
          </template>
        </el-table-column>
        <el-table-column label="Created At" prop="createTime" width="160" />
        <el-table-column label="Operations" align="center" width="160">
          <template #default="scope">
            <el-button 
              link
              type="primary" 
              icon="Edit" 
              @click="handleUpdate(scope.row)"
            >Edit</el-button>
            <el-button 
              link
              type="danger" 
              icon="Delete" 
              @click="handleDelete(scope.row)"
            >Delete</el-button>
          </template>
        </el-table-column>
      </el-table>
  
      <!-- Pagination -->
      <pagination
        v-show="total > 0"
        :total="total"
        v-model:page="queryParams.pageNum"
        v-model:limit="queryParams.pageSize"
        @pagination="getList"
      />
  
      <!-- Add/Edit Dialog -->
      <el-dialog :title="title" v-model="open" width="600px" append-to-body>
        <el-form ref="formRef" :model="form" :rules="rules" label-width="100px">
          <el-form-item label="Product ID" prop="productId" required>
            <el-input 
              v-model="form.productId" 
              placeholder="Enter product ID" 
              type="number"
            />
          </el-form-item>
          <el-form-item label="Spec Name" prop="specName" required>
            <el-input 
              v-model="form.specName" 
              placeholder="Enter specification name" 
              maxlength="100"
              show-word-limit
            />
          </el-form-item>
          
          <!-- Existing Spec Values -->
          <el-divider v-if="specValueList.length > 0" content-position="left">Specification Values</el-divider>
          <div 
            v-for="(item, index) in specValueList" 
            :key="index" 
            class="spec-value-item"
          >
            <div class="spec-header">
              <span class="spec-title">{{ item.key }}</span>
              <el-button 
                type="danger" 
                size="small" 
                circle 
                icon="Delete" 
                @click="removeSpecValue(index)"
              ></el-button>
            </div>
            <div class="value-tags">
              <el-tag
                v-for="(value, vIndex) in item.valueList"
                :key="vIndex"
                class="value-tag"
                closable
                @close="removeSpecValueItem(index, vIndex)"
              >
                {{ value }}
              </el-tag>
            </div>
          </div>
          
          <!-- Add New Spec Value -->
          <el-divider content-position="left">Add New Specification</el-divider>
          <div class="spec-value-input-container">
            <el-input
              v-model="specValue.key"
              placeholder="Specification name"
              maxlength="50"
              style="width: 200px; margin-right: 10px;"
              show-word-limit
            />
            <el-input
              v-model="specValue.values"
              placeholder="Values (comma separated: Red, Blue, L, XL)"
              maxlength="255"
              style="width: calc(100% - 290px); margin-right: 10px;"
              show-word-limit
            />
            <el-button 
              type="primary"
              :disabled="!specValue.key || !specValue.values"
              @click="addSpecValue"
            >Add</el-button>
          </div>
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
  
  <script setup>
  import { ref, reactive, toRefs, onMounted, getCurrentInstance } from 'vue'
  import { listSpec, getSpec, addSpec, updateSpec, delSpec } from '@/api/product/productSpec'
  import { ElMessage, ElMessageBox } from 'element-plus'
  
  const { proxy } = getCurrentInstance()
  
  // Data state
  const loading = ref(false)
  const showSearch = ref(true)
  const specList = ref([])
  const total = ref(0)
  const ids = ref([])
  const single = ref(true)
  const multiple = ref(true)
  const title = ref('')
  const open = ref(false)
  const specValueList = ref([])
  const specValue = ref({ key: '', values: '' })
  
  // Form data
  const data = reactive({
    queryParams: {
      pageNum: 1,
      pageSize: 10,
      productId: null,
      specName: null
    },
    form: {
      id: null,
      productId: null,
      specName: null
    },
    rules: {
      productId: [
        { required: true, message: "Product ID can't be empty", trigger: "blur" },
        { type: 'number', message: 'Product ID must be a number', trigger: 'blur', transform: val => Number(val) }
      ],
      specName: [{ required: true, message: "Specification name can't be empty", trigger: "blur" }]
    }
  })
  
  const { queryParams, form, rules } = toRefs(data)
  
  // Event handlers
  const handleQuery = () => {
    queryParams.value.pageNum = 1
    getList()
  }
  
  const resetQuery = () => {
    proxy.resetForm('queryForm')
    queryParams.value.productId = null
    handleQuery()
  }
  
  const handleSelectionChange = (selection) => {
    ids.value = selection.map(item => item.id)
    single.value = selection.length !== 1
    multiple.value = !selection.length
  }
  
  const handleAdd = () => {
    resetForm()
    open.value = true
    title.value = 'Add Product Specification'
  }
  
  const handleUpdate = (row) => {
    resetForm()
    const id = row?.id || ids.value[0]
    
    getSpec(id).then(response => {
      form.value = response.data
      
      // Parse spec values from JSON string if needed
      try {
        if (typeof response.data.specValue === 'string') {
          const parsedValue = JSON.parse(response.data.specValue)
          
          // Convert single object format to array format for the form
          if (parsedValue && !Array.isArray(parsedValue) && parsedValue.key && parsedValue.valueList) {
            specValueList.value = [parsedValue]
          } else if (Array.isArray(parsedValue)) {
            specValueList.value = parsedValue
          } else {
            specValueList.value = []
          }
        } else if (Array.isArray(response.data.specValue)) {
          specValueList.value = response.data.specValue
        } else {
          specValueList.value = []
        }
      } catch (error) {
        console.error('Failed to parse specValue:', error, response.data.specValue)
        specValueList.value = []
      }
      
      open.value = true
      title.value = 'Edit Product Specification'
    }).catch(() => {
      ElMessage.error('Failed to get specification details')
    })
  }
  
  const handleDelete = (row) => {
    const specIds = row?.id || ids.value
    if (!specIds || (Array.isArray(specIds) && !specIds.length)) {
      return ElMessage.warning('Please select at least one record')
    }
    
    ElMessageBox.confirm(
      `Are you sure you want to delete the selected specification${specIds.length > 1 ? 's' : ''}?`,
      'Delete Confirmation',
      {
        confirmButtonText: 'Delete',
        cancelButtonText: 'Cancel',
        type: 'warning'
      }
    ).then(() => {
      delSpec(specIds).then(response => {
        if (response.code === 200) {
          ElMessage.success('Deleted successfully')
          getList()
        } else {
          ElMessage.error(response.msg || 'Delete failed')
        }
      }).catch(() => {
        ElMessage.error('Delete operation failed')
      })
    }).catch(() => {})
  }
  
  // Form operations
  const resetForm = () => {
    form.value = {
      id: null,
      productId: null,
      specName: null
    }
    specValueList.value = []
    specValue.value = { key: '', values: '' }
    proxy.resetForm('formRef')
  }
  
  const addSpecValue = () => {
    // Validate inputs
    if (!specValue.value.key || !specValue.value.values) {
      return ElMessage.warning('Please enter both specification name and values')
    }
    
    const trimmedKey = specValue.value.key.trim()
    if (!trimmedKey) {
      return ElMessage.warning('Specification name cannot be empty')
    }
    
    // Split values by comma and trim each value
    const valueList = specValue.value.values
      .split(',')
      .map(v => v.trim())
      .filter(v => v)
    
    if (!valueList.length) {
      return ElMessage.warning('Please enter valid values separated by commas')
    }
    
    // Check for duplicate key
    const exists = specValueList.value.some(item => 
      item.key.toLowerCase() === trimmedKey.toLowerCase()
    )
    
    if (exists) {
      return ElMessage.warning(`Specification "${trimmedKey}" already exists`)
    }
    
    // Add the new specification
    specValueList.value.push({
      key: trimmedKey,
      valueList
    })
    
    // Reset input fields for next specification
    specValue.value = { key: '', values: '' }
  }
  
  const removeSpecValue = (index) => {
    specValueList.value.splice(index, 1)
  }
  
  const removeSpecValueItem = (specIndex, valueIndex) => {
    const spec = specValueList.value[specIndex]
    if (spec && spec.valueList) {
      spec.valueList.splice(valueIndex, 1)
      
      // If no values left, remove the whole spec
      if (spec.valueList.length === 0) {
        removeSpecValue(specIndex)
      }
    }
  }
  
  const submitForm = () => {
    proxy.$refs.formRef.validate(valid => {
      if (!valid) {
        return ElMessage.warning('Please fill in all required fields')
      }
      
      // Check if there are specification values
      if (specValueList.value.length === 0) {
        return ElMessage.warning('Please add at least one specification with values')
      }
      
      // Validate product ID
      if (!form.value.productId) {
        return ElMessage.warning('Please enter a product ID')
      }
      
      // Convert productId to number if it's a string
      form.value.productId = Number(form.value.productId)
      
      // Convert spec values to JSON string
      // If there's only one specification, use the single object format
      if (specValueList.value.length === 1) {
        form.value.specValue = JSON.stringify(specValueList.value[0])
      } else {
        // Otherwise use the array format
        form.value.specValue = JSON.stringify(specValueList.value)
      }
      
      // Determine if this is an add or update operation
      const operation = form.value.id ? updateSpec : addSpec
      
      operation(form.value).then(response => {
        if (response.code === 200) {
          ElMessage.success(`${form.value.id ? 'Updated' : 'Added'} successfully`)
          open.value = false
          getList()
        } else {
          ElMessage.error(response.msg || 'Operation failed')
        }
      }).catch((error) => {
        console.error('Form submission error:', error)
        ElMessage.error('Operation failed: ' + (error.message || 'Unknown error'))
      })
    })
  }
  
  const cancel = () => {
    open.value = false
    resetForm()
  }
  
  // Parse JSON string to object
  const parseSpecValue = (specValue) => {
    try {
      if (typeof specValue === 'string') {
        return JSON.parse(specValue)
      } else if (Array.isArray(specValue)) {
        return specValue
      } 
    } catch (error) {
      console.error('Error parsing specValue:', error)
    }
    return null
  }
  
  // Data loading
  const getList = () => {
    loading.value = true
    listSpec(queryParams.value).then(response => {
      specList.value = response.rows || []
      total.value = response.total || 0
      
      // Parse specValue JSON string for each item
      specList.value.forEach(item => {
        try {
          if (typeof item.specValue === 'string') {
            item.parsedSpecValue = JSON.parse(item.specValue)
          } else if (Array.isArray(item.specValue)) {
            item.parsedSpecValue = item.specValue
          } else {
            item.parsedSpecValue = null
          }
          console.log('Parsed specValue for ID', item.id, ':', item.parsedSpecValue)
        } catch (error) {
          console.error('Failed to parse specValue for ID', item.id, ':', error)
          item.parsedSpecValue = null
        }
      })
    }).catch(error => {
      console.error('Failed to load specification list:', error)
      specList.value = []
      total.value = 0
    }).finally(() => {
      loading.value = false
    })
  }
  
  // Lifecycle hooks
  onMounted(() => {
    getList()
  })
  </script>
  
  <style scoped>
  .app-container {
    padding: 20px;
  }
  
  .mb8 {
    margin-bottom: 16px;
  }
  
  .spec-item {
    display: flex;
    margin-bottom: 8px;
    flex-wrap: wrap;
  }
  
  .spec-key {
    font-weight: 500;
    margin-right: 8px;
    min-width: 80px;
  }
  
  .spec-values {
    display: flex;
    flex-wrap: wrap;
  }
  
  .spec-value-tag {
    margin: 0 4px 4px 0;
  }
  
  .spec-value-item {
    background-color: #f8f9fa;
    border-radius: 4px;
    padding: 12px;
    margin-bottom: 12px;
  }
  
  .spec-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 8px;
  }
  
  .spec-title {
    font-weight: bold;
    font-size: 14px;
  }
  
  .value-tags {
    display: flex;
    flex-wrap: wrap;
  }
  
  .value-tag {
    margin: 0 8px 8px 0;
  }
  
  /* Added styles for the new dialog layout */
  .spec-value-input-container {
    display: flex;
    align-items: center;
    margin-bottom: 15px;
  }
  
  .dialog-footer {
    display: flex;
    justify-content: flex-end;
    margin-top: 20px;
  }
  
  /* Improved table styling */
  .el-table .spec-item:last-child {
    margin-bottom: 0;
  }
  
  /* Add hover effect on tags */
  .value-tag:hover {
    cursor: default;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  }
  
  /* Add style for required fields */
  .el-form-item.is-required .el-form-item__label::before {
    color: #f56c6c;
  }
  </style>