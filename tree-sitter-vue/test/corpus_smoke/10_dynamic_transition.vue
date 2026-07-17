<template>
  <component :is="view" />
  <transition name="fade">
    <p v-if="visible">fades</p>
  </transition>
  <keep-alive>
    <component :is="tab" />
  </keep-alive>
</template>
