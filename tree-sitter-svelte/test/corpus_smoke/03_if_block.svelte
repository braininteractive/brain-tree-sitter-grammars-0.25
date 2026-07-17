<script>
  let user = { loggedIn: false };
</script>

{#if user.loggedIn}
  <button on:click={() => (user.loggedIn = false)}>Log out</button>
{:else}
  <button on:click={() => (user.loggedIn = true)}>Log in</button>
{/if}
