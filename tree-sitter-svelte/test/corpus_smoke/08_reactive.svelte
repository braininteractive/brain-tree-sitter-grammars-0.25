<script>
  let count = 0;
  $: doubled = count * 2;
  $: if (count > 10) {
    console.log('big');
  }
</script>

<p>{count} → {doubled}</p>
