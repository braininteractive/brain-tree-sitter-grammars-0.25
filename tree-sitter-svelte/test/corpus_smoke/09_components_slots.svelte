<script>
  import Card from './Card.svelte';
  import Button from './Button.svelte';
</script>

<Card title="Greetings">
  <p slot="body">Nested <strong>content</strong></p>
  <svelte:fragment slot="footer">
    <Button label="ok" on:click />
  </svelte:fragment>
</Card>
