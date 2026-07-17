<template>
  <ul>
    <li v-for="(item, index) in items" :key="item.id">
      {{ index }} — {{ item.label }}
    </li>
  </ul>
</template>
