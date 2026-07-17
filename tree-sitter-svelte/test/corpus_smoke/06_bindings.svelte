<script>
  let text = '';
  let checked = false;
  let selected;
</script>

<input bind:value={text} placeholder="type here" />
<input type="checkbox" bind:checked />
<select bind:value={selected}>
  <option value="a">A</option>
  <option value="b">B</option>
</select>
