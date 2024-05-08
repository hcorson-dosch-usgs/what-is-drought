<template>
  <div id="visualization">
    <DroughtThresholds />
    <ReferencesSection />
    <AuthorshipSection />
  </div>
</template>

<script setup>
import DroughtThresholds from '@/components/DroughtThresholds.vue';
import ReferencesSection from '@/components/ReferencesSection.vue';
import AuthorshipSection from '@/components/AuthorshipSection.vue';

</script>

<style lang="scss">
#visualization {
  //height: calc(100vh);
  margin: 2.5%;
  position: relative;

}

</style>
