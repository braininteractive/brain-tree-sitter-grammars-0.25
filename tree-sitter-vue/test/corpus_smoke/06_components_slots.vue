<template>
  <Card>
    <template #header>
      <h2>Title</h2>
    </template>
    <template #default="{ row }">
      <span>{{ row.name }}</span>
    </template>
  </Card>
</template>

<script>
import Card from './Card.vue';
export default { components: { Card } };
</script>
