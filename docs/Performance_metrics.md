# Performance Metrics

This section provides an overview of the performance metrics collected during the Spark Structured Streaming and PostgreSQL integration. The metrics include basic metadata, input and processing metrics, and overall performance metrics.

---

## Basic Metadata

- **ID**: `b98bc612-034d-4ac4-84d1-4a34874f63ed`
- **Run ID**: `8f3765c2-2e22-42e4-9ee1-1247783d433c`
- **Timestamp**: `2025-05-02T14:38:32.081Z`
- **Batch ID**: `1`
- **Name**: `null`

---

## Input and Processing Metrics

- **Number of Input Rows**: `125`
- **Input Rows per Second**: `4.95`
- **Processed Rows per Second**: `55.14`

---

## Duration Metrics (in milliseconds)

| Task               | Duration (ms) |
|--------------------|---------------|
| addBatch           | 1054          |
| commitOffsets      | 141           |
| getBatch           | 187           |
| latestOffset       | 724           |
| queryPlanning      | 45            |
| triggerExecution   | 2267          |
| walCommit          | 107           |


## Sources

**Source Description**: `FileStreamSource[file:/app/data]`

| Metric                 | Value    |
|------------------------|----------|
| Start Offset (logOffset) | 0        |
| End Offset (logOffset)   | 1        |
| Latest Offset            | null     |
| Number of Input Rows     | 125      |
| Input Rows per Second    | 4.95     |
| Processed Rows per Second| 55.14    |

---

## Sink

- **Sink Description**: `org.apache.spark.sql.execution.streaming.ConsoleTable$@29df96f3`
- **Number of Output Rows**: `125`
