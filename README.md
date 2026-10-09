# DevPilot 🚀

**An AI-powered GitHub repository assistant that helps developers understand and explore their codebases using natural language.**

DevPilot is a full-stack application designed to help developers interact with their GitHub repositories through an AI-powered chat interface. It combines Spring Boot, Next.js, Google Gemini, PostgreSQL, and pgvector to support a retrieval-augmented generation (RAG) architecture for codebase question answering.

## ✨ Features

- **GitHub OAuth Authentication:** Sign in and authorize access to GitHub repositories.
- **Repository Integration:** Connect GitHub repositories to the application.
- **AI-Powered Code Assistance:** Ask questions about a codebase using natural language.
- **Retrieval-Augmented Generation (RAG):** Retrieve relevant code context to help generate more relevant answers.
- **Vector Storage:** Use PostgreSQL with pgvector to store and search vector embeddings.
- **Code Indexing:** Process repository files into chunks for retrieval.
- **Modern Web Interface:** Use a Next.js frontend to access the application's authentication, dashboard, and chat interfaces.

## 🏗️ Architecture

```text
                 Developer
                     |
                     v
              Next.js Frontend
                localhost:3000
                     |
                     v
              Spring Boot Backend
                localhost:8080
                /      |       \
               /       |        \
              v        v         v
          GitHub    Gemini AI  PostgreSQL
          OAuth     Chat and    + pgvector
                    Embeddings
                                  |
                                  v
                         Vector Similarity Search
```

The application is designed around a retrieval-augmented generation workflow:

1. Authenticate the user with GitHub.
2. Access and process the selected repository.
3. Split relevant source files into smaller chunks.
4. Generate embeddings for searchable code context.
5. Store embeddings in PostgreSQL using pgvector.
6. Retrieve relevant chunks when a user asks a question.
7. Use the retrieved context to help the AI generate an answer.

### Core stack

- Backend: Java 21, Spring Boot, Spring Security, Spring AI, JPA, PostgreSQL
- AI: Google Gemini models for chat and embeddings
- Vector search: pgvector via Spring AI VectorStore
- Frontend: Next.js, React, Tailwind CSS, TypeScript
- Infrastructure: Docker Compose for PostgreSQL

## Repository structure

```text
DEVPILOT/
├── backend/                  # Spring Boot API server
│   ├── src/main/java/        # Java application code
│   ├── src/main/resources/   # application.properties and static assets
│   ├── pom.xml              # Maven configuration
│   └── mvnw                 # Maven wrapper
├── client/                  # Next.js frontend
│   ├── app/                 # App router pages
│   ├── components/          # UI components
│   ├── lib/                 # Client-side utilities
│   ├── package.json         # Frontend dependencies and scripts
│   └── next.config.ts
├── docker/                  # Docker-related config
├── docker-compose.yml       # PostgreSQL service definition
├── .env.example             # Sample environment variables
├── .gitignore
└── README.md                # Project documentation
```

## Prerequisites

Before running the project locally, make sure you have:

- Java 21+
- Maven or the included Maven wrapper
- Node.js 20+
- npm
- Docker Desktop or Docker Engine
- A GitHub OAuth app configured for local authentication
- A Gemini API key

## Configuration

Copy the example environment file and fill in the required values:

```bash
cp .env.example .env
```

The root `.env` file is used by Docker and by the backend environment. At minimum, configure:

```env
DB_URL=jdbc:postgresql://localhost:5433/devpilot
DB_USERNAME=postgres
DB_PASSWORD=your_secure_password
GEMINI_API_KEY=your_gemini_api_key
GITHUB_CLIENT_ID=your_github_oauth_client_id
GITHUB_CLIENT_SECRET=your_github_oauth_client_secret
FRONTEND_URL=http://localhost:3000
CORS_ALLOWED_ORIGINS=http://localhost:3000
TOKEN_ENCRYPTOR_PASSWORD=your_token_encryptor_password
TOKEN_ENCRYPTOR_SALT=your_token_encryptor_salt
```

## Running the project

### 1) Start PostgreSQL

```bash
docker compose up -d
```

This starts the Postgres service with pgvector enabled on port `5433`.

### 2) Start the backend

```bash
cd backend
./mvnw spring-boot:run
```

The backend runs on:

- `http://localhost:8080`

### 3) Start the frontend

In a separate terminal:

```bash
cd client
npm install
npm run dev
```

The frontend runs on:

- `http://localhost:3000`

## Typical workflow

1. Sign in with GitHub
2. Connect or select a repository
3. Index the repository contents into the vector store
4. Ask AI questions grounded in code context and repository metadata
5. Review output in the dashboard or chat experience

## Development notes

- The backend uses `spring.jpa.hibernate.ddl-auto=update` so database schema changes can be created automatically during local development.
- `spring.ai.vectorstore.pgvector.initialize-schema=true` enables the vector store schema initialization.
- The frontend uses the App Router (`app/`) in Next.js.
- The UI is designed around an AI-assisted developer experience, including repository-focused chat and dashboard interactions.

## Useful commands

### Backend

```bash
cd backend
./mvnw test
./mvnw clean package
```

### Frontend

```bash
cd client
npm run build
npm run lint
```

## Notes

- The PostgreSQL container is configured through `docker-compose.yml` and uses the `pgvector/pgvector:pg16` image.
- The backend expects GitHub OAuth credentials and Gemini API configuration to be present in `.env` before the app starts.
- The project is meant for local development and experimentation with AI-assisted code understanding workflows.

## 👨‍💻 Author

**Jayesh Patil**

- GitHub: [jayesh-patil03](https://github.com/jayesh-patil03)
- Portfolio: [jayesh-portfolio-liard.vercel.app](https://jayesh-portfolio-liard.vercel.app/)

## License

This project does not currently declare a repository license. If you plan to distribute or publish it, add an explicit license file and document the licensing terms.
