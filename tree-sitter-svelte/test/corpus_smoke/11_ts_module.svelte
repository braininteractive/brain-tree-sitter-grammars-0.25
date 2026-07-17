<script context="module" lang="ts">
  export interface Row {
    id: number;
    label: string;
  }
</script>

<script lang="ts">
  export let rows: Row[] = [];
</script>

{#each rows as row}
  <span data-id={row.id}>{row.label}</span>
{/each}
