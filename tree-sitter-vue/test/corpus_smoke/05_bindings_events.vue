<template>
  <a :href="url" :class="{ active: isActive }" :style="{ color }">
    link
  </a>
  <button @click.prevent="submit" @keyup.enter="submit">go</button>
</template>
