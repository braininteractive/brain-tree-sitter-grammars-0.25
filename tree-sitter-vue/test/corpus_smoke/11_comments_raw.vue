<template>
  <!-- outer comment -->
  <div v-html="rawHtml"></div>
  <pre v-pre>{{ not compiled }}</pre>
</template>

<script>
// plain JS comment
export default {};
</script>
