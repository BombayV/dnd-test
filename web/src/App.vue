<script setup>
import { ref } from 'vue'
const items = ref([])

const getFrequency = (freq) => items.value.filter((item) => item.frequency === freq)
const addItem = (freq) => {
	const id = items.value.length
	items.value.push({ id, title: 'New Item', frequency: freq })
};

const startDrag = (e, item) => {
	e.dataTransfer.dropEffect = 'move'
	e.dataTransfer.effectAllowed = 'move'
	e.dataTransfer.setData('itemID', item.id)
}
const onDrop = (e, freq) => {
	const itemID = e.dataTransfer.getData('itemID')
	const item = items.value.find((item) => item.id == itemID)
	item.frequency = freq
}
</script>

<template>
	<div class="absolute h-screen w-screen flex justify-end items-center font-sans">
		<div class="w-52 md:w-60 lg:w-72 xl:w-80 mr-4 h-[50%] bg-[#7A7A7AFF] rounded-l-xl flex flex-col justify-start items-center overflow-y-auto">
			<span class="text-2xl font-semibold mt-2 mb-2 w-5/6 text-right underline text-white ">RADIO</span>
			<div class="bg-neutral-600 w-5/6 rounded-lg mt-2 flex flex-col justify-start items-center">
				<h2 class="font-light text-neutral-200 mt-1.5 w-3/4 text-center border-b">Frequency #1</h2>
				<button @click="addItem(1)" @drop="onDrop($event, 1)" @dragenter.prevent @dragover.prevent class="w-full h-full flex flex-col items-center justify-start mt-2 mb-2">
					<div class="bg-neutral-700 w-5/6 text-center font-medium text-neutral-200 text-sm mt-1 mb-1 rounded pt-1 pb-1" v-for="item in getFrequency(1)" :key="item.id" draggable="true" @dragstart="startDrag($event, item)">
						{{ item.title }}
					</div>
					<span v-if="getFrequency(1).length === 0" class="text-neutral-400 font-medium text-center">No one on this frequency.</span>
				</button>
			</div>
			<div class="bg-neutral-600 w-5/6 rounded-lg mt-2 flex flex-col justify-start items-center">
				<h2 class="font-light text-neutral-200 mt-1.5 w-3/4 text-center border-b">Frequency #2</h2>
				<button @click="addItem(2)" @drop="onDrop($event, 2)" @dragenter.prevent @dragover.prevent class="w-full h-full flex flex-col items-center justify-start mt-2 mb-2">
					<div class="bg-neutral-700 w-5/6 text-center font-medium text-neutral-200 text-sm mt-1 mb-1 rounded pt-1 pb-1" v-for="item in getFrequency(2)" :key="item.id" draggable="true" @dragstart="startDrag($event, item)">
						{{ item.title }}
					</div>
					<span v-if="getFrequency(2).length === 0" class="text-neutral-400 font-medium text-center">No one on this frequency.</span>
				</button>
			</div>
			<div class="bg-neutral-600 w-5/6 rounded-lg mt-2 flex flex-col justify-start items-center mb-4">
				<h2 class="font-light text-neutral-200 mt-1.5 w-3/4 text-center border-b">Frequency #3</h2>
				<button @click="addItem(3)" @drop="onDrop($event, 3)" @dragenter.prevent @dragover.prevent class="w-full h-full flex flex-col items-center justify-start mt-2 mb-2">
					<div class="bg-neutral-700 w-5/6 text-center font-medium text-neutral-200 text-sm mt-1 mb-1 rounded pt-1 pb-1" v-for="item in getFrequency(3)" :key="item.id" draggable="true" @dragstart="startDrag($event, item)">
						{{ item.title }}
					</div>
					<span v-if="getFrequency(3).length === 0" class="text-neutral-400 font-medium text-center">No one on this frequency.</span>
				</button>
			</div>
		</div>
	</div>
</template>

<style>
/* Style the scroll */
::-webkit-scrollbar {
	width: 4px;
}

::-webkit-scrollbar-track {
	background: #444444;
}


#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
	height: 100vh;
}
</style>
