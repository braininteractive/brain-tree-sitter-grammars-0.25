<script>
export default {
  name: 'Widget',
  props: { modelValue: String },
  emits: ['update:modelValue'],
  computed: {
    upper() {
      return (this.modelValue || '').toUpperCase();
    },
  },
  methods: {
    reset() {
      this.$emit('update:modelValue', '');
    },
  },
  mounted() {
    console.log('mounted');
  },
};
</script>

<template>
  <div>{{ upper }}<button @click="reset">×</button></div>
</template>
