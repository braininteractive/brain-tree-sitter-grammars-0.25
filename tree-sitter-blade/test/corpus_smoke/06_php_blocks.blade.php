@php
  $total = 0;
  foreach ($items as $item) {
      $total += $item->price;
  }
@endphp

<p>Total is {{ $total }}</p>

@php($discount = $total > 100 ? 0.1 : 0)

@use('App\Models\Order')
