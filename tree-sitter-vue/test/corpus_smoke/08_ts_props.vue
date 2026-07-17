<script setup lang="ts">
interface Props {
  title: string;
  rows?: number[];
}
const props = defineProps<Props>();
const emit = defineEmits<{ (e: 'save', id: number): void }>();
</script>

<template>
  <h3 @dblclick="emit('save', 1)">{{ props.title }}</h3>
</template>
