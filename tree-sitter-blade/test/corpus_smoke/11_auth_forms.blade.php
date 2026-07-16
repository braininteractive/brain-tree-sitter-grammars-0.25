@auth
  <p>You are signed in.</p>
@endauth

@guest('admin')
  <p>Please sign in as an administrator.</p>
@endguest

<form method="POST" action="/profile">
  @csrf
  @method('PUT')
  <input type="email" name="email" value="{{ old('email') }}">
  @error('email')
    <div class="error">{{ $message }}</div>
  @enderror
  <button type="submit">Save</button>
</form>

@can('update', $post)
  <a href="/posts/{{ $post->id }}/edit">Edit</a>
@endcan
