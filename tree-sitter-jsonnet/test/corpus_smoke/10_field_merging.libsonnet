// Field merging with +: and object-level composition with +.
local base = {
  labels: { app: "web" },
  ports: [80],
};

base + {
  labels+: { tier: "frontend" },
  ports+: [443],
  annotations+:: { internal: true },
} + {
  replicas: 2,
}
