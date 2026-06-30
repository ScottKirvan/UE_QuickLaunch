import { defineConfig } from 'vitepress'

export default defineConfig({
  title: "UE QuickLaunch",
  description: "Quick launcher for Unreal Engine projects",
  base: '/UE_QuickLaunch/',
  themeConfig: {
    nav: [
      { text: 'Home', link: '/' },
      { text: 'GitHub', link: 'https://github.com/ScottKirvan/UE_QuickLaunch' }
    ],
    socialLinks: [
      { icon: 'github', link: 'https://github.com/ScottKirvan/UE_QuickLaunch' },
      { icon: 'discord', link: 'https://discord.gg/TN6XJSNK5Y' }
    ]
  }
})
