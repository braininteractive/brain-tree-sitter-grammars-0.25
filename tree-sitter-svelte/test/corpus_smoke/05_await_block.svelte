<script>
  let promise = fetch('/api/data').then((r) => r.json());
</script>

{#await promise}
  <p>loading…</p>
{:then data}
  <p>got {data.length} rows</p>
{:catch error}
  <p class="error">{error.message}</p>
{/await}
