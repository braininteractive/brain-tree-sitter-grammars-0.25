@extends('layouts.app')

@section('title', 'Dashboard')

@section('content')
  <h1>Dashboard</h1>
  <p>Main content goes here.</p>
@endsection

@section('sidebar')
  @parent
  <p>Extra sidebar content.</p>
@endsection

<footer>
  @yield('footer', 'Default footer')
</footer>
