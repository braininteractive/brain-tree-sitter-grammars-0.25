<script>
  let items = ['a', 'b', 'c'];
</script>

<ul>
  {#each items as item, i (item)}
    <li>{i + 1}: {item}</li>
  {:else}
    <li>empty</li>
  {/each}
</ul>
