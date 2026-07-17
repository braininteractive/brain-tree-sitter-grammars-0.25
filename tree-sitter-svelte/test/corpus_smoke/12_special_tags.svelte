<svelte:head>
  <title>Demo page</title>
</svelte:head>

<svelte:window on:resize={() => {}} />

{@html '<em>raw</em>'}
{@debug}

<!-- a comment node -->
<slot name="default">fallback</slot>
