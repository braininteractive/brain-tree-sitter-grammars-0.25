<script>
  let count = 0;
  function handle(event) {
    count += 1;
  }
</script>

<button on:click={handle}>clicked {count}</button>
<button on:click|preventDefault|stopPropagation={handle}>modified</button>
<div on:keydown={(e) => e.key === 'Enter' && handle(e)} role="button" tabindex="0">kbd</div>
