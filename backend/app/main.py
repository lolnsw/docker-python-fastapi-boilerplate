from fastapi import FastAPI

app = FastAPI(
    title="Simple API",
    description="A simple API with health and hello endpoints",
    version="0.0.1"
)

@app.get("/health")
async def health():
    return {"status": "OK"}

@app.get("/hello")
async def hello():
    return {"message": "hello"} 