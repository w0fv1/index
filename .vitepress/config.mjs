import { defineConfig } from 'vitepress'

export default defineConfig({
  title: "w0fv1主页",
  description: "w0fv1 index",
  head: [
    ['link', { rel: 'icon', href: '/favico.ico' }]
  ],
  themeConfig: {
  logo: "/logo.png",

    nav: [
      { text: '主页', link: '/' },
      // { text: '独立开发', link: '/indev/' },
      { text: '知乎', link: 'https://www.zhihu.com/people/wu-fa-bei-ya/' },
      { text: 'BiliBili', link: 'https://space.bilibili.com/25657230/' },
    ],

    footer: {
      message: '<a href="http://beian.miit.gov.cn/">备案号：京ICP备04000001号-2</a>',
      copyright: `版权所有 © 2024-${new Date().getFullYear()} w0fv1`
    },
    sidebar: {
      "/indev/":{
        text: '独立开发',
        text: 'Guide',
        items: [
          { text: '独立开发', link: '/indev/' },
          { text: 'Week1_信息与思路', link: '/indev/week1' },
        ]
      }
    },

    socialLinks: [
      { icon: 'github', link: 'https://github.com/w0fv1' }
    ],
    search: {
      provider: 'local'
    }
  },
  sitemap:{
    hostname: 'https://w0fv1.dev'
  }
})
