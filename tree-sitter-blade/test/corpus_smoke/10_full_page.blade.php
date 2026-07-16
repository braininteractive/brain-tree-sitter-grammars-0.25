<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>{{ config('app.name') }}</title>
    <link rel="stylesheet" href="/css/app.css">
  </head>
  <body>
    <nav class="navbar">
      <ul>
        @foreach ($links as $link)
          <li><a href="{{ $link->url }}">{{ $link->label }}</a></li>
        @endforeach
      </ul>
    </nav>
    <main>
      @if (session('status'))
        <div class="alert">{{ session('status') }}</div>
      @endif
      <h1>Welcome</h1>
    </main>
    <script src="/js/app.js"></script>
  </body>
</html>
