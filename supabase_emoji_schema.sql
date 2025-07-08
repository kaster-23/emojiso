
-- Table: public.emojis
CREATE TABLE public.emojis (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    emoji TEXT NOT NULL,
    slug TEXT UNIQUE NOT NULL,
    name TEXT NOT NULL,
    group TEXT,
    category TEXT,
    unicode_version TEXT,
    emoji_version TEXT,
    keywords TEXT[],
    fuzzy_search TEXT,
    language_data JSONB
);

-- Optional Table: public.emoji_components
CREATE TABLE public.emoji_components (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    component_name TEXT NOT NULL,
    emoji TEXT NOT NULL
);

-- Row-Level Security: Allow read-only public access
ALTER TABLE public.emojis ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Public read access"
    ON public.emojis
    FOR SELECT
    USING (true);

ALTER TABLE public.emoji_components ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Public read access"
    ON public.emoji_components
    FOR SELECT
    USING (true);
