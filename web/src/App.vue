<script setup>
import {onMounted, onUnmounted, ref} from 'vue';
const freqs = ref([440, 880, 1760]);
const items = ref([])

const fetchNui = async (cbName, data) => {
	const options = {
		method: "POST",
		headers: {
			"Content-Type": "application/json; charset=UTF-8",
		},
		body: JSON.stringify(data),
	};
	const resourceName = window.GetParentResourceName ? GetParentResourceName() : "dnd-test";
	const resp = await fetch(`https://${resourceName}/${cbName}`, options);
	return await resp.json();
};

const getFrequency = (freq) => items.value.filter((item) => item.frequency === freq)
const addItem = (freq) => {
	fetchNui('join_on_click', { frequency: freq}).then((data) => {
		if (data.allowed) {
			items.value.push(data);
		} else {
			console.log('Cannot join this frequency');
		}
	});
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
	console.log(item, freq)
	item.frequency = freq
}

const handleMessage = e => {
	if (e.data.action === 'create_radios') {
		const { frequencies } = e.data
		for (const freq of frequencies) {
			freqs.value.push(freq.freq)
		}
	}
}

onMounted(() => window.addEventListener('message', handleMessage))
onUnmounted(() => window.removeEventListener('message', handleMessage))
</script>

<template>
	<div class="absolute h-screen w-screen flex justify-end items-center font-sans">
		<div class="w-52 md:w-60 lg:w-72 xl:w-80 mr-4 h-[50%] bg-[#7A7A7AFF] rounded-l-xl flex flex-col justify-start items-center overflow-y-auto">
			<span class="text-2xl font-semibold mt-2 mb-2 w-5/6 text-right underline text-white ">RADIO</span>
			<div v-for="freq in freqs" class="bg-neutral-600 w-5/6 rounded-lg mt-2 flex flex-col justify-start items-center">
				<h2 class="font-light text-neutral-200 mt-1.5 w-3/4 text-center border-b">Frequency #{{freq}}</h2>
				<button @click="addItem(freq)" @drop="onDrop($event, freq)" @dragenter.prevent @dragover.prevent class="w-full h-full flex flex-col items-center justify-start mt-2 mb-2">
					<div class="bg-neutral-700 w-5/6 text-center font-medium text-neutral-200 text-sm mt-1 mb-1 rounded pt-1 pb-1" v-for="item in getFrequency(freq)" :key="item.id" draggable="true" @dragstart="startDrag($event, item)">
						{{ item.title }}
					</div>
					<span v-if="getFrequency(freq).length === 0" class="text-neutral-400 font-medium text-center">No one on this frequency.</span>
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
