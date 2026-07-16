@foreach ($users as $user)
  <li>{{ $user->name }}</li>
@endforeach

@forelse ($posts as $post)
  <article>{{ $post->title }}</article>
@empty
  <p>No posts yet.</p>
@endforelse

@for ($i = 0; $i < 10; $i++)
  <span>Value {{ $i }}</span>
@endfor

@while ($item = array_shift($queue))
  <p>{{ $item }}</p>
@endwhile

@foreach ($rows as $row)
  @continue($row->hidden)
  <td>{{ $row->value }}</td>
  @break($loop->iteration > 100)
@endforeach
