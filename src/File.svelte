<script lang="ts">
  import { onMount } from "svelte";
  export let title: string
  export let level: number = 0
  export let href: string = ''
  const indent = 4
  let element: HTMLElement

  onMount(() => {
    const css = window.getComputedStyle(element)
    const padding = css.getPropertyValue('padding').split(' ')
    if (padding.length === 2)
      element.style.padding = `${padding[0]} ${parseFloat(padding[1].replace('px', '')) * (level + 1) + level * indent}px`
    else
      element.style.padding = `${padding[0]} ${parseFloat(padding[0].replace('px', '')) * (level + 1) + level * indent}px`
  })
</script>

  {#if href !== ''}
    <div bind:this={element} class="w-full px-3 py-2 md:px-2 md:py-1">
      <a href="{href}" class="hover:underline">{title}</a>
    </div>
  {:else}
    <button bind:this={element} class="dark:hover:bg-zinc-600 hover:bg-zinc-200 w-full px-3 py-2 md:px-2 md:py-1 text-left">
      {title}
    </button>
  {/if}
  <!-- <h1 class="">{title}</h1> -->
