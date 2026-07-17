<template>
  <div>
    <p v-if="ready">ready</p>
    <p v-else-if="loading">loading</p>
    <p v-else>idle</p>
    <input v-model="query" />
    <span v-show="query.length > 0">searching {{ query }}</span>
  </div>
</template>
