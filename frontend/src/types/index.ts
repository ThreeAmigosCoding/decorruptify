export type VerdictType = "PRISON" | "SUSPENDED" | "ACQUITTED" | "FINE";

export interface Verdict {
  id: number;
  court: string;
  verdictNumber: string;
  date: string;
  judgeName: string;
  prosecutor: string;
  defendantName: string;
  criminalOffense: string;
  appliedProvisions: string[];
  verdict: VerdictType | null;
  officialPosition: string | null;
  abuseOfAuthority: boolean | null;
  organizedGroup: boolean | null;
  materialGain: number | null;
  materialDamage: number | null;
  briberyAmount: number | null;
  previouslyConvicted: boolean | null;
  numDefendants: number | null;
  voluntaryDisclosure: boolean | null;
  damageToPublicInterest: boolean | null;
  sentenceMonths: number | null;
}

export interface SimilarVerdict {
  id: number;
  court: string;
  verdictNumber: string;
  date: string;
  judgeName: string;
  defendantName: string;
  verdict: VerdictType;
  sentenceMonths: number;
  similarity: number;
}
