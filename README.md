# DevPilot 🚀 — AI-Powered GitHub Codebase Assistant

An AI-powered GitHub repository assistant that helps developers understand and explore their codebases using natural language.

**🌐 Live Demo:** [https://dev-pilot-gules.vercel.app](https://dev-pilot-gules.vercel.app)  
**💻 GitHub Repository:** [https://github.com/jayesh-patil03/DevPilot](https://github.com/jayesh-patil03/DevPilot)

DevPilot is a full-stack application that allows developers to connect GitHub repositories, index source code, and ask questions through an AI-powered chat interface. It uses Retrieval-Augmented Generation (RAG) to retrieve relevant code context and generate contextual answers.

## ✨ Features

- **GitHub OAuth 2.0:** Authenticate users and access authorized repositories.
- **Repository Integration:** Connect and browse GitHub repositories.
- **AI-Powered Code Assistance:** Ask natural-language questions about a codebase.
- **RAG Architecture:** Retrieve relevant code chunks to ground AI-generated responses.
- **Semantic Search:** Store and search vector embeddings using PostgreSQL and pgvector.
- **Code Indexing:** Split repository source files into chunks for embedding and retrieval.
- **Modern UI:** Access authentication, repository management, and code-focused chat through Next.js.

## 🏗️ Architecture

```text
                 Developer
                     |
                     v
             Next.js Frontend
                  Vercel
                     |
              HTTPS API Requests
                     |
                     v
            Spring Boot Backend
                  Render
              /      |       \
             /       |        \
            v        v         v
         GitHub    Gemini    Neon PostgreSQL
         OAuth     AI API      + pgvector
                                 |
                                 v
                         Vector Similarity Search
```

### Deployment architecture

| Component | Technology | Hosting |
|---|---|---|
| Frontend | Next.js, React, TypeScript | Vercel |
| Backend | Java 21, Spring Boot, Spring AI | Render |
| Database | PostgreSQL, pgvector | Neon |
| Authentication | GitHub OAuth 2.0 | GitHub OAuth App |
| AI services | Google Gemini | Gemini API |

## 🧠 How It Works

1. The user signs in through GitHub OAuth.
2. DevPilot retrieves the user's authorized repositories.
3. Selected repository files are fetched and processed.
4. Source code is split into smaller chunks.
5. Gemini generates embeddings for searchable code context.
6. Embeddings are stored in PostgreSQL using pgvector.
7. When the user asks a question, relevant code chunks are retrieved through vector similarity search.
8. The retrieved context is supplied to the AI model to generate a relevant answer.

## 🛠️ Tech Stack

**Backend:** Java 21, Spring Boot, Spring Security, Spring AI, Spring Data JPA, Hibernate, Maven

**Frontend:** Next.js, React, TypeScript, Tailwind CSS

**AI and Vector Search:** Google Gemini, embeddings, Retrieval-Augmented Generation (RAG), PostgreSQL, pgvector

**Authentication:** GitHub OAuth 2.0

**Deployment and Tools:** Docker, Docker Compose, Render, Vercel, Neon, Git, GitHub

## 🌐 Live Deployment

Try DevPilot here:

**[Launch DevPilot →](https://dev-pilot-gules.vercel.app)**

The frontend, backend, and database are deployed separately:

- **Frontend:** [https://dev-pilot-gules.vercel.app](https://dev-pilot-gules.vercel.app)
- **Backend:** [https://devpilot-backend-63ih.onrender.com](https://devpilot-backend-63ih.onrender.com)
- **Database:** Hosted on Neon PostgreSQL with pgvector.

### Deployment notes

- The frontend communicates with the Spring Boot backend over HTTPS.
- Backend credentials and API keys are configured using hosting-platform environment variables.
- GitHub OAuth uses the deployed backend callback URL.
- PostgreSQL connection settings are configured through environment variables.
- The backend is containerized using Docker and deployed on Render.
- Render's free instance may sleep after inactivity, which can cause a delay on the first request.
- Gemini API quota restrictions may temporarily prevent repository indexing or AI responses.

## 📁 Repository Structure

```text
DEVPILOT/
├── backend/                  # Spring Boot backend
│   ├── src/main/java/        # Java source code
│   ├── src/main/resources/   # Application configuration
│   ├── Dockerfile            # Backend Docker image
│   ├── pom.xml               # Maven dependencies
│   └── mvnw                  # Maven wrapper
├── client/                   # Next.js frontend
│   ├── app/                  # App Router pages
│   ├── components/           # UI components
│   ├── hooks/                # Custom React hooks
│   ├── lib/                  # API and client utilities
│   └── package.json          # Frontend dependencies
├── docker/
│   └── postgres/             # PostgreSQL initialization
├── docker-compose.yml        # Local PostgreSQL service
├── .env.example              # Environment variable template
├── .gitignore
└── README.md
```

## ⚙️ Prerequisites

To run DevPilot locally, install:

- Java 21+
- Maven or the included Maven wrapper
- Node.js and npm
- Docker Desktop or Docker Engine
- A GitHub OAuth App
- A Google Gemini API key

## 🔐 Environment Configuration

Create a local `.env` file from the example template:

```bash
cp .env.example .env
```

Configure the required variables with your own credentials:

```env
DB_NAME=devpilot
DB_URL=jdbc:postgresql://localhost:5433/devpilot
DB_USERNAME=postgres
DB_PASSWORD=your_secure_database_password

GEMINI_API_KEY=your_gemini_api_key

GITHUB_CLIENT_ID=your_github_oauth_client_id
GITHUB_CLIENT_SECRET=your_github_oauth_client_secret

FRONTEND_URL=http://localhost:3000
CORS_ALLOWED_ORIGINS=http://localhost:3000

TOKEN_ENCRYPTOR_PASSWORD=your_long_random_secret
TOKEN_ENCRYPTOR_SALT=your_16_character_hex_salt
```

For the frontend, configure `client/.env.local`:

```env
NEXT_PUBLIC_API_BASE_URL=http://localhost:8080
```

**Security:** Never commit `.env`, `.env.local`, real API keys, OAuth secrets, or production database credentials to GitHub. Use Render and Vercel environment-variable settings for production configuration.

## 🚀 Run Locally

### 1. Start PostgreSQL

From the project root:

```bash
docker compose up -d
```

This starts PostgreSQL with pgvector on host port `5433`.

### 2. Start the backend

Open a terminal:

```bash
cd backend
```

On Windows PowerShell:

```powershell
.\mvnw.cmd spring-boot:run
```

On Linux or macOS:

```bash
./mvnw spring-boot:run
```

Backend URL: `http://localhost:8080`

### 3. Start the frontend

Open another terminal:

```bash
cd client
npm install
npm run dev
```

Frontend URL: `http://localhost:3000`

### 4. Configure GitHub OAuth for local development

Set your GitHub OAuth App callback URL to:

```text
http://localhost:8080/login/oauth2/code/github
```

For production, use the deployed backend callback URL instead.

## 🔄 Typical Workflow

1. Open DevPilot and sign in with GitHub.
2. Browse connected repositories.
3. Select a repository and start indexing.
4. Wait for indexing to finish.
5. Open a repository chat and ask questions about the code.
6. Review the AI-generated answers and any available code references.

## 🧰 Useful Commands

### Backend

```bash
cd backend
./mvnw clean package
./mvnw test
```

On Windows, use `.\mvnw.cmd` instead of `./mvnw` if required.

### Frontend

```bash
cd client
npm install
npm run build
npm run lint
```

### Docker

```bash
docker compose up -d
docker compose ps
docker compose logs postgres
docker compose down
```

## 📝 Development Notes

- Hibernate uses `spring.jpa.hibernate.ddl-auto=update` for development schema updates.
- Spring AI initializes the pgvector store schema.
- The Next.js frontend uses the App Router.
- Repository indexing and AI responses depend on GitHub access, Gemini API availability, and applicable quotas.
- Production credentials must be configured through hosting-platform environment variables.

## 👨‍💻 Author

**Jayesh Patil**

- GitHub: [jayesh-patil03](https://github.com/jayesh-patil03)
- Portfolio: [jayesh-portfolio-liard.vercel.app](https://jayesh-portfolio-liard.vercel.app/)
