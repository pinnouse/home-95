<template>
    <div class="projects">
        <h3>My Projects</h3>
        <p>This is a list of a lot of the projects I've worked on and am proud of.</p>
        <div class="projects-container">
            <div class="project"
                v-for="(project, i) in projects"
                :key="`${i}-projects-${windowIndex}`">
                <h4>{{project.name}}</h4>
                <div class="content">
                    <img :src="project.src">
                    <span v-html="project.description"></span>
                    <a v-for="(link, j) in project.links"
                        :key="`${i}-projects-link-${j}-${windowIndex}`"
                        :href="link.to"
                        target="_blank" rel="noopener">
                        {{link.text}}
                    </a>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
let projects = [
    {
        name: "Zero Two Bot",
        description: `Zero Two Bot is a Discord bot that I made using NodeJS and the library DiscordJS.
        This bot interacts with and hosts an API through HTTP and is currently still maintained by me.`,
        src: "./img/z2b.xyz_.png",
        links: [
            {
                to: "https://z2b.xyz",
                text: "Website"
            }
        ]
    },
    {
        name: "OfflineTV Mock Site",
        description: `A website I built for the streaming group OfflineTV.
        It is written in vanilla HTML, CSS, and JS, and a websocket was built alongside to cache calls to Twitch and Twitter APIs.`,
        src: "./img/offline_.png",
        links: [
            {
                to: "https://gnowbros.com/offline",
                text: "Live Website"
            },
            {
                to: "https://github.com/pinnouse/offline",
                text: "GitHub Repo"
            }
        ]
    },
    {
        name: "Reina Bot",
        description: `My first attempt at a Discord bot.
        I built this bot to first learn JavaScript and NodeJS.
        This bot included API calls for services such as Google, MyAnimeList, etc.
        It also had a chatbot built on machine learning technologies written in Python.`,
        src: "./img/reina_.png",
        links: [
            {
                to: "https://bitbucket.org/pinnouse/ReinaBot",
                text: "BitBucket Repo"
            },
            {
                to: "https://github.com/pinnouse/ReinaChat",
                text: "Chatbot Repo"
            }
        ]
    }
]

export default {
    data() {
        return {
            projects: projects
        }
    },
    fileName: 'projects',
    name: 'Projects',
    icon: './img/projects.png',
    props: {
        windowIndex: Number
    }
}
</script>

<style>
.projects h3,
.projects h4 {
    margin: 0;
}

.projects-container {
    display: flex;
    flex-direction: column;
}

.projects-container > .project {
    display: block;
    margin: 12px 6px;
}

.projects-container > .project > h4 {
    font-size: 19px;
}

.projects-container > .project > .content {
    padding: 8px;
    margin-top: 4px;
    background: white;
    border: 4px inset #a8a8a8;
}

.project > .content > span {
    display: block;
}

.project > .content > img {
    width: 50%;
}

.project > .content > a {
    display: inline-block;
    margin: 2px 4px;
}
</style>