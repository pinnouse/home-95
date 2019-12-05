<template>
  <div id="app"
    @mousemove="moveMouse($event)"
    @mouseup="unassignMove()">
    <div class="icons-container">
      <div class="icon" v-for="(p, i) in pages"
        :key="`${i}-icon`"
        @dblclick="openPage(p)"
        @click="select(i)"
        @mouseup.stop
        :class="{
          selected: selectedIcon.includes(i)
          }"
        >
        <img :src="p.icon" :alt="`${p.name} icon`">
        <span class="name">
          {{p.fileName || p.name}}
        </span>
      </div>
    </div>

    <div class="window" v-for="(p, i) in actPages"
      :key="`${i}-active-window`"
      :style="{
        'z-index': order[i],
        left: `${p.x}px`,
        top: `${p.y}px`
        }"
      :class="{
        active: order[i] == order.length - 1
        }"
      @mousedown="putOnTop(i)">
      <div class="title-bar"
        @mousedown="assignMove($event, i)">
        <img :src="p.component.icon">
        <span class="title">{{p.component.name}}</span>
        <span class="close button"
          @mousedown.stop
          @mouseup="closePage(i)">&times;</span>
      </div>
      <component class="content" :is="p.component" :windowIndex="i"></component>
    </div>

    <div class="close-all"
      @mouseup="closeAll()">
      <span>Close all</span>
    </div>
  </div>
</template>

<script>
import pages from "./pages.js";

export default {
  name: 'app',
  data() {
    return {
      pages: pages,
      selectedIcon: [],
      activePages: [],
      order: [],
      moveIndex: -1,
      heldDown: 0,
      moveOffset: [0, 0],
      placementOffset: 0
    }
  },
  watch: {
    placementOffset: function(newPO) {
      if (newPO > 6)
        this.placementOffset = 0;
    }
  },
  computed: {
    actPages() {
      return this.activePages.filter(p => p !== undefined && p.component !== undefined);
    }
  },
  methods: {
    select(iconIndex) {
      this.selectedIcon.splice(0, this.selectedIcon.length);
      if (!this.selectedIcon.includes(iconIndex)) {
        this.selectedIcon.push(iconIndex);
      }
    },
    assignMove(event, index) {
      this.moveIndex = index;
      this.moveOffset = [
        event.x - this.activePages[index].x,
        event.y - this.activePages[index].y
        ];
    },
    moveMouse(event) {
      if (this.moveIndex >= 0 && event.buttons === 1) {
        this.activePages[this.moveIndex].x = event.x - this.moveOffset[0];
        this.activePages[this.moveIndex].y = event.y - this.moveOffset[1];
      }
    },
    unassignMove() {
      this.moveIndex = -1;
      this.selectedIcon.splice(0, this.selectedIcon.length);
    },
    openPage(page) {
      if (this.activePages.length > 10) {
        alert("Window limit exceeded. Please close a/some window(s).\nWhy did you even open so many??");
        return;
      }
      let placement = 24 + (this.placementOffset++) * 16;
      this.activePages.push({
        x: placement,
        y: placement,
        component: page
      })
      this.order.push(this.order.length);
    },
    closePage(index) {
      this.activePages.splice(index, 1);
      this.order.splice(index, 1);
    },
    putOnTop(index) {
      let old = this.order[index];
      for (let i = 0; i < this.order.length; i++) {
        if (this.order[i] > old)
          this.$set(this.order, i, this.order[i]-1);
      }
      this.$set(this.order, index, this.order.length - 1);
    },
    closeAll() {
      this.activePages.splice(0, this.activePages.length);
      this.order.splice(0, this.order.length);
    }
  },
}
</script>

<style>
#app {
  font-family: Arial, Helvetica, sans-serif;
  background: linear-gradient(rgb(46, 19, 41), rgb(88, 18, 70));
  padding: 8px;
  flex: 1;
}

.close-all {
  z-index: 1000;
  cursor: pointer;
  display: inline-block;
  position: fixed;
  top: 10px;
  right: 10px;
  padding: 12px;
  text-align: center;
  color: #fff;
  background: rgb(31, 11, 27);
}

.icons-container {
  display: flex;
  flex-direction: column;
  justify-content: flex-start;
  align-items: flex-start;
}

.icon {
  display: inline-block;
  width: 120px;
  margin-bottom: 18px;
  user-select: none;
  text-align: center;
}

.icon > img {
  display: block;
  height: 50px;
  width: 50px;
  padding: 10px;
  margin: 0 auto;
}

.icon > .name {
  display: inline-block;
  text-align: center;
  color: #ccc;
  padding: 2px 4px;
  overflow: hidden;
  text-overflow: ellipsis;
}

.icon.selected > * {
  background: #161666;
}

.icon.selected > .name {
  color: #fff;
}

.window {
  z-index: 1;
  display: flex;
  flex-direction: column;
  position: absolute;
  top: 0;
  left: 0;
  width: 800px;
  height: 600px;
  background: #8b8b8b;
  border: 2px outset #a8a8a8;
}

.window > .title-bar {
  position: relative;
  display: flex;
  flex-direction: row;
  justify-content: flex-start;
  align-items: center;
  user-select: none;
  background: #444444;
  color: #bdbdbd;
  border-bottom: 2px outset #a8a8a8;
  padding: 0 2px;
  height: 28px;
}

.window.active > .title-bar {
  background: #171c52;
  color: #ffffff;
}

.window > .title-bar > .button {
  display: inline-block;
  position: absolute;
  top: 0;
  right: 0;
  width: 20px;
  height: 18px;
  background: #b8b8b8;
  color: #000000;
  margin: 2px;
  border: 2px outset #a8a8a8;
  text-align: center;
  line-height: .7em;
  font-size: 28px;
}

.window > .title-bar > .button:active {
  background: #aaaaaa;
  border: 2px inset #000000;
}


.window > .title-bar > img {
  height: 16px;
  width: 16px;
  margin: 2px;
  filter: grayscale(100%);
}

.window.active > .title-bar > img {
  filter: none;
}

.window > .title-bar > .title {
  padding: 4px 2px 2px;
  font-weight: bold;
}

.window > .content {
  padding: 2px;
  height: 100%;
  margin: 4px;
  overflow-x: hidden;
}

::-webkit-scrollbar {
  width: 22px;
}

::-webkit-scrollbar-track {
  background: #bdbdbd;
}

::-webkit-scrollbar-thumb {
  background: #818181;
  border: 2px outset #bbbbbb;
}

::-webkit-scrollbar-thumb:active {
  background: #7e7e7e;
  border: 2px inset #aaaaaa;
}
</style>
