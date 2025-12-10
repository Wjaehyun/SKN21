# Hugging Face Transformers Learning Repository

## Project Overview
Educational project demonstrating Hugging Face Transformers library concepts:
- **Transfer Learning** - leveraging pretrained models to solve new problems
- **Pipeline API** - simplified end-to-end inference (preprocessing → inference → postprocessing)
- **AutoClass Loading** - model/tokenizer discovery and initialization
- **Fine-tuning** - adapting pretrained models to custom datasets

## Key Architecture Concepts

### Transfer Learning Strategy
Choose based on dataset size and domain similarity to pretrained model:
- **Freeze backbone, train head**: Small dataset + similar domain
- **Fine-tune top layers**: Large dataset + similar domain  
- **Full fine-tuning**: Large dataset + different domain (requires most training time)

Reference: `01_전이학습_huggingface.ipynb` markdown cells explain backbone vs. head distinction.

### Hugging Face Ecosystem
- **Transformers**: PyTorch/TensorFlow pretrained models (BERT, GPT-2, etc.)
- **Datasets**: Load/preprocess data with `datasets.load_dataset()` - supports Hub datasets, local CSVs
- **Tokenizers**: Handle text→tokens using model-specific tokenizers (always load tokenizer matching the model)
- **Hub**: Central model/dataset repository at huggingface.co

## Workflow Patterns

### Loading Models & Tokenizers
```python
from transformers import AutoModel, AutoTokenizer

# Auto classes handle model type detection automatically
model = AutoModel.from_pretrained("model_id")
tokenizer = AutoTokenizer.from_pretrained("model_id")  # MUST match model ID
```

Models cache to: `~/.cache/huggingface`

### Pipeline Pattern (Simplest Approach)
```python
from transformers import pipeline

# Specify task; default model auto-loads for that task
pipe = pipeline("text-classification")  # Uses default model
pipe = pipeline("text-classification", model="specific-model-id")

# Single call handles preprocessing + inference + postprocessing
result = pipe("input text")
```

Supports diverse tasks: `text-classification`, `text-generation`, `translation`, `question-answering`, `token-classification`, `image-classification`, etc.

### Dataset Processing Pattern
```python
from datasets import load_dataset

# Load from Hub or local files
dataset = load_dataset("imdb")  # Hub dataset
dataset = load_dataset("csv", data_files={"train": "path.csv"})

# Transform data: map() applies function to all samples
def tokenize(examples):
    return tokenizer(examples["text"], truncation=True)
dataset = dataset.map(tokenize, batched=True)

# Filter: keep only rows where function returns True
dataset = dataset.filter(lambda x: len(x["text"]) > 50)
```

## Notebook Structure

| Notebook | Purpose |
|----------|---------|
| `01_전이학습_huggingface.ipynb` | Transfer learning fundamentals (zero-shot, transfer, fine-tuning concepts) |
| `02_HuggingFace_pipeline.ipynb` | Task-specific pipeline usage (NLP/vision tasks with practical examples) |
| `03_HuggingFace_AutoClass.ipynb` | AutoClass model/tokenizer loading (kcbert Korean example) |
| `04_HuggingFace_파인튜닝.ipynb` | End-to-end fine-tuning workflow with Datasets and Trainer |

## Critical Implementation Details

### Tokenizer Alignment
- Always load tokenizer using the **same model ID** as the model
- Tokenizer handles preprocessing (encoding) matching the model's training format
- Mismatch causes incorrect inference results

### Device Management
```python
# Specify compute device explicitly
pipe = pipeline("task", device="cuda:0")  # GPU
pipe = pipeline("task", device="cpu")     # CPU
```

### Hub Integration
- Set `HUGGINGFACE_HUB_TOKEN` for model uploads (see `参照_python-dotenv.ipynb` for .env usage)
- Use `trust_remote_code=True` cautiously - downloads and executes remote model code
- Fast tokenizers (Rust-based) preferred but use `use_fast=False` if unsupported

### Data & Figures
- `/data`: Sample datasets (CSV, etc.) for fine-tuning examples
- `/figures`: Architecture diagrams explaining transfer learning and fine-tuning strategies

## Common Issues & Solutions

**Issue**: Symlink warning on Windows when loading datasets  
**Solution**: Expected behavior - HF cache inefficiently uses disk on Windows without symlink support (not critical)

**Issue**: Out of memory during fine-tuning  
**Solution**: Reduce `per_device_train_batch_size`, enable gradient checkpointing, or use LoRA (see PEFT library)

**Issue**: Model predictions don't match expectations  
**Solution**: Verify tokenizer ID matches model ID; check token length matches model's max_position_embeddings

## Development Patterns

- **Notebook-first**: All code in Jupyter notebooks with markdown explanations
- **Task-based organization**: Each notebook demonstrates one use case from concept to execution
- **Pretrained-by-default**: Leverage HF Hub models rather than training from scratch
- **Korean language focus**: kcbert (Korean BERT) used for Korean NLP tasks
- **Experimentation**: Notebooks are exploratory; preserve learning progression

