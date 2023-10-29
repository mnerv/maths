<script lang="ts">
    import { onMount } from "svelte";
    let pdfs: string[] = []

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
    })
</script>

<main>
    <h1>Links to Notes</h1>
    <ul>
    {#each pdfs as pdf}
        <li><a href="{pdf}">{pdf.replace('/pdf/', '')}</a></li>
    {/each}
    </ul>
    <!-- <embed width="100%" height="1024pt" src="{pdf}" type="application/pdf"/> -->
</main>
