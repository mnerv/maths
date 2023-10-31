<script lang="ts">
  import File from './File.svelte';
  import { type NodeT } from './FileTree'

  export let tree: NodeT[]
</script>

{#each tree as item}
  <File title={item.name} level={item.level} href={item.href}/>
  {#if Array.isArray(item.children)}
    <svelte:self tree={item.children} />
  {/if}
{/each}
