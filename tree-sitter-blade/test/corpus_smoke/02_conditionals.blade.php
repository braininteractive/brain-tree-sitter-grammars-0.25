@if ($user->isAdmin())
  <p>Welcome, admin!</p>
@elseif ($user->isEditor())
  <p>Welcome, editor!</p>
@else
  <p>Welcome, guest!</p>
@endif

@unless ($signedIn)
  <a href="/login">Sign in</a>
@endunless

@isset($records)
  <p>Records are set.</p>
@endisset

@empty($records)
  <p>No records.</p>
@endempty
