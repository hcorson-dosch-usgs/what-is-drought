import { createRouter, createWebHistory } from 'vue-router'
import Visualization from '../views/Visualization.vue'
import Error404 from '../components/Error404.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'VisualizationContent',
      component: Visualization
    },
    {
      path: '/index.html',
      name: 'Index',
      component: Visualization
    },
    {
      path: "/404",
      name: "error404",
      component: Error404
    },
    { 
      path: '/:pathMatch(.*)*', 
      name: 'not-found', 
      component: Error404 },,
  ]
})

export default router
