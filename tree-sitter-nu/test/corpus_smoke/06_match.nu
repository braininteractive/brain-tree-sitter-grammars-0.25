match (date now | date format "%u") {
  "6" | "7" => "weekend"
  _ => "weekday"
}
