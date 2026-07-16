<div class="page">
  @include('shared.errors')
  @include('partials.card', ['title' => 'Card title'])
  @includeIf('partials.optional')
  @includeWhen($showBanner, 'partials.banner', ['level' => 'info'])
  @includeUnless($isGuest, 'partials.account')
  @each('partials.comment', $comments, 'comment', 'partials.no-comments')
</div>
