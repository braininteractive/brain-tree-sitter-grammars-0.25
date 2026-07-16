@switch($level)
  @case(1)
    <p>First level</p>
    @break
  @case(2)
    <p>Second level</p>
    @break
  @default
    <p>Unknown level</p>
@endswitch

@once
  <script>console.log('runs once');</script>
@endonce

@push('scripts')
  <script src="/js/extra.js"></script>
@endpush

<head>
  @stack('scripts')
</head>

@verbatim
  <div>{{ thisIsNotBlade }}</div>
@endverbatim
