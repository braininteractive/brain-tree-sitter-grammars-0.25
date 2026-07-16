@props(['type' => 'info', 'message'])

@aware(['color' => 'gray'])

<div {{ $attributes->merge(['class' => 'alert alert-' . $type]) }}>
  {{ $message }}
  {{ $slot }}
</div>
