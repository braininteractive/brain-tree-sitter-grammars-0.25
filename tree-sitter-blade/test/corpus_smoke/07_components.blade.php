<x-alert type="error" :message="$message" />

<x-alert class="mt-4">
  <x-slot:title>
    Server error
  </x-slot>
  <strong>Whoops!</strong> Something went wrong.
</x-alert>

<x-forms.input name="email" type="email" />

<x-dynamic-component :component="$componentName" class="mt-4" />
