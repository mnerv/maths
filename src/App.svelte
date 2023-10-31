<script lang="ts">
  import { onMount } from 'svelte'
  import File from './File.svelte';
  import FileTree from './FileTree.svelte';
  import { pathsToFileTree, type NodeT } from './FileTree';

  let pdfs: string[] = []
  let isCollapse = true

  let tree: NodeT[] = []

  onMount(async () => {
    const links = await fetch('./pdf/registry.txt')
    .then(res => {
      if (res.ok) return res.text()
      else throw new Error(`Can't download registry.txt`)
    })
    .then(txt => txt.trim())
    .then(txt => txt.replaceAll('.tex', '.pdf'))
    .then(txt => txt.replaceAll('./', '/pdf/'))
    .then(txt => txt.split('\n'))
    .catch(_ => [])

    if (links.length === 0) return
    pdfs = links

    tree = pathsToFileTree(links)
    console.log(tree);
  })
</script>

<main class="h-full p-4 pb-32 md:w-[512pt] mx-auto md:items-center">
  <h1 class="text-3xl font-bold mb-5">Notes</h1>
  <div class="rounded-md overflow-hidden dark:bg-zinc-800 bg-zinc-100 w-full">
    <FileTree {tree} />
  </div>
</main>
