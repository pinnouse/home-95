<template>
    <div class="about">
        <h3>About Me</h3>
        <p>
            Hi, my name is Nicholas.
            <br />
            I'm primarily a web developer but also have experience in other fields like Machine Learning and Game Development.
            <br />
            <br />
            I'm currently the lead web designer for
            <a href="https://zerotwo.bot" target="_blank" rel="noopener">ZeroTwo Bot</a>,
            a Disord bot serving 110,000+ servers.
        </p>
        <p>
            GitHub: <a href="https://github.com/pinnouse" target="_blank" rel="noopener">pinnouse</a>
            <br />
            Twitter: <a href="https://twitter.com/pinnouse" target="_blank" rel="noopener">@pinnouse</a>
            <br />
            Email: <a href="mailto:futawong@owo.soy" target="_blank" rel="noopener">futawong@owo.soy</a>
            <br />
            Discord: <span class="mention">pinnouse#7766</span>
        </p>
        
    </div>
</template>

<script>
export default {
    fileName: 'about me',
    name: 'About',
    icon: './img/about.png'
}
</script>

<style>
.about h3 {
    margin: 0;
}

.about .mention {
    cursor: default;
    color: #7289da;
    background: rgba(45, 49, 66, 0.445);
    padding: 0 2px;
}

.about .mention:hover {
    color: #fff;
    background: rgba(114, 137, 218, .7);
}
</style>