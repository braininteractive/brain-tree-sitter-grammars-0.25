<%!
    private int hitCount = 0;

    public synchronized int nextHit() {
        return ++hitCount;
    }
%>
<%! private static final String GREETING = "Hi"; %>
<p>You are visitor number <%= nextHit() %>.</p>
