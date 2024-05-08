import { createRouter, createWebHistory } from 'vue-router'
import VisualizationView from '../views/VisualizationView.vue'
import Error404Page from '../views/Error404Page.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'VisualizationContent',
      component: VisualizationView
    },
    {
      path: '/index.html',
      name: 'Index',
      component: VisualizationView
    },
    {
      path: "/404",
      name: "error404",
      component: Error404Page
    },
    { 
      path: '/:pathMatch(.*)*', 
      name: 'not-found', 
      component: Error404Page },
  ]
})

export default router
